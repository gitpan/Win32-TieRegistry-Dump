package Win32::TieRegistry::Dump;
our $VERSION = 0.03;	# Updated tests and turned off warnings

use 5.006;
use strict;
# do not use warnings;
use Carp;
use Win32::TieRegistry ( Delimiter=>"/", ArrayValues=>0 );
no strict 'refs';

=head1 NAME

Win32::TieRegistry::Dump - dump Win32 registry tree

=head1 SYNOPSIS

	use Win32::TieRegistry::Dump
	$_ = Win32::TieRegistry::Dump::toArray ("LMachine/Software/LittleBits/");
	while (my ($key, $value) = each %{$_} ){
		warn "$key = $value\n";
	}
	exit;

=head1 DESCRIPTION

Returns an array of values in a Win32 registry tree, one key per array slot.

=head1 DEPENDENCIES

	Win32::TieRegistry

=cut

sub toArray {
	my $literal = shift or carp __PACKAGE__."::toArray requires an argument" and return undef;
	my $$rkey = $Registry->{$literal}
		or  warn "* Can't read the registry key for $literal:\n $^E\n" and return undef;
	return &_iterate ($$rkey,$literal);
}


sub _iterate { my ($$key,$root) = (shift,shift);
	my $info = shift  || {};
	foreach my $entry (  keys(%$$key)  ) {
		if ($$key->SubKeyNames){
			&_iterate( $$key->{$entry}, $root.$entry, $info );
		} else {
			$info->{$root.$entry} = %$$key->{$entry};
		}
	}
	return $info;
}

1; # Return cleanly from module

=head1 EXPORTS

None.

=head1 AUTHOR

Lee Goddard <http://www.leegoddard.com/>
Mailto: <Lee@LeeGoddard.com>

=head1 LICENCE AND COPYRIGHT

Copyrigh (C) 2001 Lee Goddard

This is free software made available under the same terms as Perl itself;

=head1 SEE ALSO

See L<Win32::TieRegistry>;
L<Win32::TieRegistry::PMVersionInfo>;
