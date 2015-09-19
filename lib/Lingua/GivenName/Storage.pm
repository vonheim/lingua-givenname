package Lingua::GivenName::Storage;

use Moose;
use Lingua::GivenName::Storage::JSONFile;
use Lingua::GivenName::Storage::YAMLFile;


sub load {
    my ($self, $path) = @_;
    return $self->_storage_by_filename($path)->load($path);
}


sub save {
    my ($self, $path, $list) = @_;
    return $self->_storage_by_filename($path)->save($path, $list);
}


sub _storage_by_filename {
    my ($self, $path) = @_;
    return Lingua::GivenName::Storage::JSONFile->new() if $path =~ /json$/;
    return Lingua::GivenName::Storage::YAMLFile->new() if $path =~ /ya?ml$/;
    die "Can not resolve storage for $path";
}

1;
