# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 2 };
use Win32::TieRegistry::PMVersionInfo;
ok(1); # If we made it this far, we're ok.

use Win32::TieRegistry::Dump
$_ = Win32::TieRegistry::Dump::toArray ("LMachine/Software/LittleBits/");
if ($_){
	while (my ($key, $value) = each %{$_} ){
		warn "$key = $value\n";
	}
}
ok(not undef, $_);
exit;


#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

