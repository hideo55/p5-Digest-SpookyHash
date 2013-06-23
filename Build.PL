use strict;
use warnings;
use 5.008008;
use builder::MyBuilder;

my $builder = builder::MyBuilder->new(
    name                 => 'Digest-SpookyHash',
    module_name          => 'Digest::SpookyHash',
    license              => 'perl',
    dist_author          => 'Hideaki Ohno <hide.o.j55 {at} gmail.com>',
    no_index => { 'directory' => [ 't', 'xt', 'inc', 'eg' ] },
    test_files => ( -d '.git' || $ENV{RELEASE_TESTING} ) ? [qw(t/ xt/)] : ['t/'],
);

$builder->create_build_script();
