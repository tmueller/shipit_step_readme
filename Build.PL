use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'ShipIt::Step::Readme',
    license             => 'perl',
    dist_author         => q{Thomas Mueller <tmueller@cpan.org>},
    dist_version_from   => 'lib/ShipIt/Step/Readme.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'ShipIt-Step-Readme-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
