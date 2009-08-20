use Test::More tests => 5;

use Scalar::Sealer qw(seal unseal);

my $foo = 'foo';
my $bar = 'bar';
my ($seal1,$unsealer1) = seal($foo);

#Type check
is(ref $seal1,'Scalar::Sealed');
is(ref $unsealer1,'Scalar::Unsealer');

#Unseals correctly
is(unseal($seal1,$unsealer1),$foo);

my ($seal2,$unsealer2) = seal($bar);

#Check we can't unseal without the right unsealer
eval {
    unseal($seal2,$unsealer1);
};

is(!!$@,1);

#Check we can't unseal with the right unsealer
eval {
    unseal($seal1,$unsealer2);
};

is(!!$@,1);
