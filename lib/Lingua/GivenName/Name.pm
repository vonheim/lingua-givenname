package Lingua::GivenName::Name;

use strict;
use Moose;

has 'name' => (is=>'rw', isa=>'Str');

has 'genders' => (is=>'rw', isa=>'ArrayRef[Str]', default=>sub {[]});

has 'regions' => (is=>'rw', isa=>'ArrayRef[Str]', default=>sub {[]});


sub is_gender {
    my ($self, $gender) = @_;
    return 1 if grep {$_ eq $gender} @{$self->genders};
}


sub is_male {
    my ($self) = @_;
    return $self->is_gender('male');
}


sub is_female {
    my ($self) = @_;
    return $self->is_gender('female');
}

sub is_unisex {
    my ($self) = @_;
    return @{$self->genders} == 2;
}


sub is_region {
    my ($self, $region) = @_;
    return 1 if grep {lc($region) eq $_} @{$self->regions};
}


sub add_gender {
    my ($self, $gender) = @_;
    return if $self->is_gender($gender);
    push @{$self->genders}, $gender;
}


sub add_region {
    my ($self, $region) = @_;
    return if $self->is_region($region);
    push @{$self->regions}, $region;
}


sub merge {
    my ($self, $other_name) = @_;

    foreach( @{$other_name->genders} ) {
        $self->add_gender($_);
    }
    foreach( @{$other_name->regions} ) {
        $self->add_region($_);
    }
}


sub as_string {
    my ($self) = @_;
    return ($self->name || '')
        .
        ' ('. join('/', @{$self->genders}) .')'
        .
        ' '. join(', ', @{$self->regions});
}


__PACKAGE__->meta->make_immutable;
1;
