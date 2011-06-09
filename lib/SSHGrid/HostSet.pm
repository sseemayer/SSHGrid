=pod

=head1 NAME

SSHGrid::HostSet - Collection of hosts in an SSHGrid 

=head1 DESCRIPTION


=head2 Methods

=cut

package SSHGrid::HostSet;
use strict;
use warnings;
use diagnostics;

sub new {
	my $type = shift;

	# Default parameters
	my $parameters = SSHGrid->_load_parameters({
		Name		=> 0,
		Hosts 		=> 0,
	}, \@_);
	
	my $self = {
		parameters => $parameters,
	};

	bless $self, $type;
}

sub load_hostfile {
	my ($type, $hostfile) = @_;

	my @hostsets = ();
	open(HF, "< $hostfile") or die("Could not open $hostfile for reading!");
	my ($current_groupname, @current_hosts);
	while(my $line = <HF>) {
		chomp $line;

		if($line =~ m/^\[\s*(?<groupname>(?:\w|\s|[()*!.,;+-])+)\s*\]\s*$/) {
			# [GROUPNAME]
			if(@current_hosts) {
				push @hostsets, SSHGrid::HostSet->new(Name => \$current_groupname, Hosts => \@current_hosts);
			}

			$current_groupname = $+{'groupname'};
			@current_hosts = ();

		} elsif($line =~ m/^\t(?<hostname>[a-zA-Z0-9.@-]+)\s*$/) {
			#	user@hostname.domain.org
			push @current_hosts, $+{'hostname'};

		} elsif($line =~ m/^\s*$/) {
			# ignore all-whitespace lines

		} else {
			die("Unrecognized line in $hostfile: '$line'");
		}

	}

	# add last group
	if(@current_hosts) {
		push @hostsets, SSHGrid::HostSet->new(Name => \$current_groupname, Hosts => \@current_hosts);
	}
	close(HF);
	return \@hostsets;
}


sub get_name {
	my ($self) = @_;
	return $self->{parameters}->{Name};
}

sub get_hosts {
	my ($self) = @_;
	return $self->{parameters}->{Hosts};
}

sub get_set_master {
	my ($self) = @_;
	return $self->{parameters}->{Hosts}->[0];
}

=head1 BUGS

Highly likely, this is the first release.

=head1 AUTHOR

Stefan Seemayer <seemayer@rostlab.org>

=cut

1;
