use strict;
use Test::More;
use utf8;
use Lingua::GivenName::Storage;

use_ok('Lingua::GivenName');



my $storage = Lingua::GivenName::Storage->new;
my $list = $storage->load('t/rundata/names.yml');
my $names = Lingua::GivenName->new(list=>$list);
{
    my $name = $names->lookup('Øystein');
    ok($name, 'lookup()');
    is($name->name, 'øystein', 'lookup returns correct name');
    is_deeply($name->genders, ['male'], 'lookup returns correct gender');
    ok($name->is_male(), 'lookup returns correct is_male()');
    ok(!$name->is_female(), 'lookup returns correct is_female()');
    is_deeply($name->regions, ['norway'], 'lookup returns correct regions');
}
{
    my @names = $names->names_in("Øystein XXX\nEva");
    is_deeply([map {$_->name} @names], [qw/øystein eva/], 'names_in()');
}
{
    my $name = $names->lookup('Øystein');
    ok($name, 'Non ascii letters in lookup()');
}
{
    my @names = $names->names_in('A boy called Øystein');
    my $names = join '', map {$_->name} @names;
    is($names, 'øystein', 'Non ascii letters in names_in()');
}
{
    is($names->guess_region("øystein alex eva"), 'norway', 'guess_region()');
}
done_testing;
