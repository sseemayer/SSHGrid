=pod

=head1 TITLE

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

use Cwd;
use IPC::Open3;

sub new {
	my $type = shift;

	# Default parameters
	my $parameters = $type->_load_parameters({
		HostsSource 		=> 0,
		RemoteRoot 		=> '~/.sshgrid',
		SubdirectoryFormat	=> '%t',
	}, \@_);
	
	

	my $self = {
		hosts => 0,
		parameters => $parameters,
		
	};

	bless $self, $type;
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
			Hosts => 0,
			Filenames => 0,
			Subdir => 0,
			LocalRoot => getcwd(),
			RemoteRoot => $self->{parameters}->{RemoteRoot},
		}, \@_);

	die "Must specify filenames to upload!" unless $pars->{Filenames};
	die "Must specify subdir to upload to!" unless $pars->{Subdir};

	my $hosts = $pars->{Hosts} ? $pars->{Hosts} : $self->hosts;
	die "No hosts found!" unless $hosts;

	my $firsthost = $hosts->[0];

	# create destination folders
	$self->remote_mkdirs(	Host => $firsthost, 
				Folders => ['.'],
				Subdir => $pars->{Subdir},
				RemoteRoot => $pars->{RemoteRoot});

	$self->remote_copy($pars->{Filenames}, "$firsthost:$pars->{RemoteRoot}/$pars->{Subdir}/" );
	
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

sub remote_command {
	my ($self,$hostname,$cmd,$async) = @_;
	print STDERR "on $hostname: '$cmd'\n";

	if($async) {
		open(SSH, "ssh $hostname bash -c '$cmd' |") or die("Coult not run ssh: $!");
		close(SSH);
	} else {
		return system('ssh', $hostname, "bash -c '$cmd'");	
	}
}

sub remote_commands {
	my ($self,$hostname,$cmds) = @_;
	return $self->remote_command($hostname, join(";", @$cmds));
}

sub remote_all_command {
	my ($self,$cmd) = @_;

	my $hosts = $self->hosts;
	die "No hosts found!" unless $hosts;

	for my $host (@$hosts) {
		$self->remote_command($host,$cmd);	
	}
}

sub remote_all_commands {
	my ($self,$cmds) = @_;
	return $self->remote_all_command(join(";", @$cmds));
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


sub hosts {
	my ($self) = @_;

	return $self->{hosts} if $self->{hosts};
	die "No HostsSource defined!" unless defined $self->{parameters}->{HostsSource};

	return $self->_get_hosts_from_file if $self->{parameters}->{HostsSource}->{FileSource};
	
	die "Could not find a valid HostsSource!";
}

sub _get_hosts_from_file {
	my ($self) = @_;

	my $filename = $self->{parameters}->{HostsSource}->{FileSource};

	open(IN, "< $filename") or die("Could not open $filename for reading!");
	my @hosts = <IN>;
	map { chomp } @hosts;
	close(IN);

	$self->{hosts} = \@hosts;

	return \@hosts;
}

=head1 BUGS

Highly likely, this is the first release.

=head1 AUTHOR

Stefan Seemayer <seemayer@rostlab.org>

=cut

1;
