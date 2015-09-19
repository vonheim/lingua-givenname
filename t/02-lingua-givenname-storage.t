use strict;
use Test::More;
use utf8;
use Lingua::GivenName::List;
use Lingua::GivenName::Name;
use File::Temp qw(tempfile);

use_ok('Lingua::GivenName::Storage');


my $list = Lingua::GivenName::List->new();
$list->add( Lingua::GivenName::Name->new(name=>'øystein', regions=>['norway'], genders=>['male']) );
$list->add( Lingua::GivenName::Name->new(name=>'alex', regions=>['norway'], genders=>['male']) );
$list->add( Lingua::GivenName::Name->new(name=>'alex', regions=>['sweden'], genders=>['female', 'male']) );
$list->add( Lingua::GivenName::Name->new(name=>'eva', regions=>['norway'], genders=>['female']) );


my $storage = Lingua::GivenName::Storage->new;
foreach my $extension ('.json', '.yml') {
    my (undef, $path) = tempfile(SUFFIX => $extension);
    $storage->save($path, $list);

    my $loaded = $storage->load($path);
    is_deeply($list->as_hash, $loaded->as_hash, "$extension stored and loaded");
}

done_testing;
