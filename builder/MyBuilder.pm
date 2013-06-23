package builder::MyBuilder;
use strict;
use warnings;
use 5.008008;
use base 'Module::Build::XSUtil';
use Config ();

if ( !$Config::Config{use64bitint} ) {
    die "OS unsupported:\n# 64bit integer unsupported.";
}

sub new {
    my ( $self, %args ) = @_;
    $self->SUPER::new(
        %args,
        needs_compiler       => 1,
        c_source             => 'src',
        xs_files             => { './src/Spooky.xs' => './lib/Digest/SpookyHash.xs' },
        extra_compiler_flags => [ '-x', 'c++' ],
        extra_linker_flags   => ['-lstdc++'],
        add_to_cleanup       => [
            'Digest-SpookyHash-*', 'lib/Digest/*.c', 'lib/Digest/*.h', 'lib/Digest/*.xs',
            'lib/Digest/*.o',      'MANIFEST.bak'
        ],
        meta_add             => { keywords => [qw/spooky spookyhash hash/], },
        generate_ppport_h    => 'lib/Digest/ppport.h',
        needs_compiler_cpp   => 1,
    );
}

1;
__END__
