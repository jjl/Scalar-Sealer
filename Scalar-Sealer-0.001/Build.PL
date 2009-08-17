use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Scalar::Sealer',
    license             => 'perl',
    dist_author         => 'James Laver <sprintf qw(%s@%s.%s cpan jameslaver com)>',
    dist_version_from   => 'lib/Scalar/Sealer.pm',
    dist_abstract       => 'E-like Sealer/Unsealer pairs for secure programming',
    build_requires => {
        'Test::More'                => 0,
    },
    requires       => {
        perl                        => '5.0',
    },
    add_to_cleanup      => [ 'Scalar-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
