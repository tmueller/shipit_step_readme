use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'ShipIt::Step::Readme',
    license             => 'perl',
    dist_author         => q{Thomas Mueller <tmueller@cpan.org>},
    dist_version_from   => 'lib/ShipIt/Step/Readme.pm',
    build_requires => {qw~
        Test::More      0
        Test::Exception 0
    ~},
    requires    => {qw~
        Pod::Readme     0
        ShipIt          0.53
        base            0
        strict          0
    ~},
    add_to_cleanup      => [ 'ShipIt-Step-Readme-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
