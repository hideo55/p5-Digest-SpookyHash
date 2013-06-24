use strict;
use warnings;
use Test::More;
use Config;
use Digest::SpookyHash qw(spooky32 spooky64 spooky128);

no warnings 'portable';

my @testdata = (
    {   key => 'spooky',
        32  => 0x413159c7,
        64  => 0x3adc6517413159c7,
        128 => [ 0x3adc6517413159c7, 0x427d4d963e2fa3f9 ],
    },
    {   key => 'Hello, World',
        32  => 0x1241b3cf,
        64  => 0xbe1be90f1241b3cf,
        128 => [ 0xbe1be90f1241b3cf, 0xfc8b765d6519527a ],
    },
    {   key => 'abcdef',
        32  => 0xc1806d46,
        64  => 0xe58acc6ac1806d46,
        128 => [ 0xe58acc6ac1806d46, 0xe883303f848b6936 ],
    }
)
if( $Config::Config{byteorder} eq '87654321' ){
@testdata = (
    {   key => 'spooky',
        32  => 0x36833DB8,
        64  => 0x1F975F38573862C,
        128 => [ 0x13BE9B8336833DB8, 0x427d4d963e2fa3f9 ],
    },
    {   key => 'Hello, World',
        32  => 0x3E58A8C4,
        64  => 0xF7A3283C3E58A8C4,
        128 => [ 0xF7A3283C3E58A8C4, 0xfc8b765d6519527a ],
    },
    {   key => 'abcdef',
        32  => 0x3FBC960C,
        64  => 0x89F7BCF13FBC960C,
        128 => [ 0x89F7BCF13FBC960C, 0xe883303f848b6936 ],
    }
)
}
;

for my $i ( 0 .. @testdata - 1 ) {
    my $key = $testdata[$i]->{key};
    is spooky32( $key, 0 ), $testdata[$i]->{32}, 'spooky32_' . ( $i + 1 );
    is spooky64( $key, 0 ), $testdata[$i]->{64}, 'spooky64_' . ( $i + 1 );
    my @hashes = spooky128( $key, 0 );
    is_deeply \@hashes, $testdata[$i]->{128}, 'spooky128_' . ( $i + 1 );
}

done_testing();
__END__
