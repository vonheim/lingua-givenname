package Lingua::GivenName::Storage::JSONFile;

use Lingua::GivenName::List;
use Moose;
use File::Slurp;
use JSON::XS;


sub load {
    my ($self, $path) = @_;
    my $json = read_file($path);
    return Lingua::GivenName::List->new(names=>decode_json($json));
}


sub save {
    my ($self, $path, $list) = @_;
    my $json = encode_json($list->as_hash);
    write_file($path, $json);
}

1;
