=pod

=head1 NAME

SSHGrid.pm - Poor-mans grid computing via SSH

=head1 SYNOPSIS

	use SSHGrid;

=head1 DESCRIPTION


=head2 METHODS



=cut

package SSHGrid;
use strict;
use warnings;
use diagnostics;

use SSHGrid::HostSet;

use Cwd;
use IPC::Open3;

use vars qw($VERSION);
$VERSION = '0.02';

sub new {
	my $type = shift;

	# Default parameters
	my $parameters = $type->_load_parameters({
		HostsSource 		=> 0,
		RemoteRoot 		=> '~/.sshgrid',
		SubdirectoryFormat	=> '%t',
	}, \@_);

	my $self = {
		hostsets => SSHGrid::HostSet->load_hostfile($parameters->{HostsSource}),
		parameters => $parameters,
		
	};

	bless $self, $type;
}

sub get_host_sets {
	my ($self) = @_;
	return $self->{hostsets};
}

sub get_total_host_count {
	my ($self) = @_;

	my $count=0;
	for my $hs (@{$self->{hostsets}}) {
		$count += $hs->get_host_count();
	}

	return $count;
}

sub get_new_subdir {
	my $self = shift;
	
	my $sd = $self->{parameters}->{SubdirectoryFormat};

	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time); 
	my $timestamp = sprintf "%4d-%02d-%02d_%02d-%02d-%02d",$year+1900,$mon+1,$mday,$hour,$min,$sec;

	$sd =~ s/%t/$timestamp/;

	return $sd;
}

sub upload {

	my $self = shift;
	my $pars = $self->_load_parameters({
			Host => 0,
			Filenames => 0,
			Subdir => 0,
			LocalRoot => getcwd(),
			RemoteRoot => $self->{parameters}->{RemoteRoot},
		}, \@_);

	die "Must specify filenames to upload!" unless $pars->{Filenames};
	die "Must specify subdir to upload to!" unless $pars->{Subdir};

	# create destination folders
	$self->remote_mkdirs(	Host => $pars->{Host}, 
				Folders => ['.'],
				Subdir => $pars->{Subdir},
				RemoteRoot => $pars->{RemoteRoot});

	$self->remote_copy($pars->{Filenames}, "$pars->{Host}:$pars->{RemoteRoot}/$pars->{Subdir}/" );
	
}

sub remote_mkdirs {
	my $self = shift;
	my $pars = $self->_load_parameters({
			Host => 0,
			Folders => 0,
			Subdir => 0,
			RemoteRoot => $self->{parameters}->{RemoteRoot},
		}, \@_);

	die "Must specify folders to create!" unless $pars->{Folders};
	die "Must specify subdir!" unless $pars->{Subdir};

	my $host = $pars->{Host} ? $pars->{Host} : $self->hosts->[0];
	
	die "No hosts found!" unless $host;

	my @commands = ();	
	for my $folder (@{$pars->{Folders}}) {
		my $abspath = "$pars->{RemoteRoot}/$pars->{Subdir}/$folder";
		push @commands, "test -d $abspath || mkdir -p $abspath";
	}

	$self->remote_commands($host, \@commands);
}

sub remote_copy {
	my ($self, $from, $to) = @_;
	return system('scp', @$from, $to);
}

sub remote_open {
	my ($self,$hostname,$cmd) = @_;

	my $cmdline = "ssh $hostname \"bash -c '$cmd'\"";
	#print STDERR "$cmdline\n";

	my $out;
	my $pid = open3(0,$out,0, $cmdline);

	my $buf = "";
	while(my $line = <$out>) {
		$buf .= $line;
	}

	waitpid($pid, 0);
	my $exitstatus = $? >> 8;
	
	$exitstatus == 0 or die("remote_open failed with exit code $exitstatus");

	return $buf;
}

sub remote_command {
	my ($self,$hostname,$cmd,$async) = @_;
	#print STDERR "on $hostname: '$cmd'\n";

	if($async) {
		my $cmdline = "ssh $hostname \"nohup bash -c '$cmd'\"";
		#print STDERR "$cmdline\n";
		system("( $cmdline ) &"); #or die("Could not run ssh: $!");
	} else {
		return system('ssh', $hostname, "bash -c '$cmd'");	
	}
}

sub remote_commands {
	my ($self,$hostname,$cmds) = @_;
	return $self->remote_command($hostname, join(";", @$cmds));
}

sub _load_parameters {
	my ($self, $defaults, $parameters) = @_;


	my %pars;
	if(UNIVERSAL::isa( $parameters, "HASH" )) {
		%pars = %$parameters;
	} else {
		my @p = @$parameters;
		%pars = @p;
	}


	# set all parameters that are specified in the argument hash
	for my $pkey (keys %pars) {
		exists($defaults->{$pkey}) or die "Parameter $pkey is unknown!";
		$defaults->{$pkey} = $pars{$pkey};
	}

	return $defaults;
}



=head1 BUGS

Highly likely, this is the first release.

=head1 AUTHOR

Stefan Seemayer <seemayer@rostlab.org>

=cut

1;
