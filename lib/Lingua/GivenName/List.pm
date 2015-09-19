package Lingua::GivenName::List;
use Moose;
use Lingua::GivenName::Name;

has 'names' => (is=>'rw', isa=>'HashRef[Lingua::GivenName::Name|HashRef]', default=>sub {{}});


sub add {
    my ($self, $name) = @_;
    if( my $existing = $self->lookup($name->name) ) {
        $existing->merge($name);
    } else {
        $self->names->{ $name->name } = $name;
    }
}


sub lookup {
    my ($self, $name) = @_;
    $name = lc($name);

    my $found = $self->names->{$name};
    return unless $found;

    return $found if ref $found ne 'HASH';

    return $self->names->{$name} = Lingua::GivenName::Name->new(name=>$name, %$found);
}


sub name_strings {
    my ($self) = @_;
    return keys %{$self->names};
}


sub add_list {
    my ($self, $list) = @_;
    foreach my $name ($list->name_strings) {
        $self->add(
            $list->lookup($name)
        );
    }
}


sub as_hash {
    my ($self) = @_;
    my $names = $self->names;
    foreach my $name (keys %$names) {
        my $entry = $names->{$name};
        if( ref $entry ne 'HASH' ) {
            $names->{$name} = {
                genders => $entry->genders,
                regions => $entry->regions,
            };
        }
    }
    return $names;
}


1;
