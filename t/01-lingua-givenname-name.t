use strict;
use Test::More;

use_ok('Lingua::GivenName::Name');

{
    my $name = Lingua::GivenName::Name->new(genders=>['male']);
    ok($name->is_male, 'male is_male()');
    ok(!$name->is_female, 'male is_female()');
    ok(!$name->is_unisex, 'male is_unisex()');
}
{
    my $name = Lingua::GivenName::Name->new(genders=>['female']);
    ok($name->is_female, 'female is_female()');
    ok(!$name->is_male, 'female is_male()');
    ok(!$name->is_unisex, 'female is_unisex()');
}
{
    my $name = Lingua::GivenName::Name->new(genders=>['female', 'male']);
    ok($name->is_female, 'unisex is_female()');
    ok($name->is_male, 'unisex is_male()');
    ok($name->is_unisex, 'unisex is_unisex()');
}
{
    my $name = Lingua::GivenName::Name->new(regions=>['norway']);
    ok($name->is_region('Norway'), 'is_region()');
}

done_testing;
