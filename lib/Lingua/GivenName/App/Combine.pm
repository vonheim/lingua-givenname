package Lingua::GivenName::App::Combine;

use MooseX::App::Command;
use Lingua::GivenName::Storage;
use Lingua::GivenName::List;

extends qw(Lingua::GivenName::App);

command_short_description 'Combine several name data files.';


option 'source' => (
    is            => 'rw',
    isa           => 'ArrayRef[Str]',
    required      => 1,
    documentation => 'Names file(s) you want to include in the result',
);


option 'output' => (
    is            => 'rw',
    isa           => 'Str',
    required      => 1,
    documentation => 'Where to write the result',
);


sub run {
    my ($self) = @_;

    # Start with empty list...
    my $result_list = Lingua::GivenName::List->new;

    # ... add each of the files
    my $storage = Lingua::GivenName::Storage->new;
    foreach my $path (@{$self->source}) {
        my $list = $storage->load($path);
        $result_list->add_list($list);
    }

    # .. and output result as YAML
    $storage->save($self->output, $result_list);
}


1;
