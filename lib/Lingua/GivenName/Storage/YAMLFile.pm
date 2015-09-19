package Lingua::GivenName::Storage::YAMLFile;

use Lingua::GivenName::List;
use Moose;
use YAML qw(LoadFile DumpFile);


sub load {
    my ($self, $path) = @_;
    my $names = LoadFile($path);
    return Lingua::GivenName::List->new(names=>$names);
}


sub save {
    my ($self, $path, $list) = @_;
    DumpFile($path, $list->as_hash);
}

1;
