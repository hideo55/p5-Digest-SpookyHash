use strict;
use warnings;
use Module::Build::Pluggable (
    'CPANfile',
    'GithubMeta',
    'XSUtil' => {
        'cc_warnings' => 0,
        'c++'         => 1,
        'ppport'      => 'lib/Digest/ppport.h',
        'xshelper'    => 'lib/Digest/xsutil.h',
    }
);
use Config ();

if ( !$Config::Config{use64bitint} ) {
    warn "# 64bit integer not supported.";
    exit 1;
}

my $builder = Module::Build::Pluggable->new(
    name                 => 'Digest-SpookyHash',
    module_name          => 'Digest::SpookyHash',
    license              => 'perl',
    dist_author          => 'Hideaki Ohno <hide.o.j55 {at} gmail.com>',
    needs_compiler       => 1,
    c_source             => 'src',
    extra_compiler_flags => [ '-x', 'c++' ],
    extra_linker_flags   => ['-lstdc++'],
    xs_files             => { './src/Spooky.xs' => './lib/Digest/SpookyHash.xs' },
    add_to_cleanup       => [
        'Digest-SpookyHash-*', 'lib/Digest/*.c', 'lib/Digest/*.h', 'lib/Digest/*.xs',
        'lib/Digest/*.o',      'MANIFEST.bak'
    ],
    no_index => { 'directory' => [ 't', 'xt', 'inc', 'eg' ] },
    test_files => ( -d '.git' || $ENV{RELEASE_TESTING} ) ? [qw(t/ xt/)] : ['t/'],
    create_readme  => 1,
    create_license => 1,
    meta_add       => {
        keywords  => [qw/spooky spookyhash hash/],
        resources => { bugtracker => 'https://github.com/hideo55/Digest-SpookyHash/issues', },
    },
);

$builder->create_build_script();
