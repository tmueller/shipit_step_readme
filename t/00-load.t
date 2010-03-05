#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'ShipIt::Step::Readme' ) || print "Bail out!
";
}

diag( "Testing ShipIt::Step::Readme $ShipIt::Step::Readme::VERSION, Perl $], $^X" );
