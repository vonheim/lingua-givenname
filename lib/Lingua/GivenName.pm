package Lingua::GivenName;

use Moose;
use Lingua::GivenName::Storage;
use FindBin;


has 'list' => (is=>'rw', isa=>'Lingua::GivenName::List', builder=>'_build_list', lazy=>1);


sub _build_list {
    my ($self) = @_;
    my $storage = Lingua::GivenName::Storage->new;
    return $storage->load($self->_resolve_path);
}


sub _resolve_path {
    my ($self) = @_;
    my $file = 'data/names.json';
    return "$FindBin::Bin/../$file";
}



sub lookup {
    my ($self, $name) = @_;
    return $self->list->lookup($name);
}


sub names_in {
    my ($self, $string) = @_;

    return unless $string;

    my $re = '('. join('|', $self->list->name_strings) .')';
    my @names = $string =~ /\b$re\b/gsi;
    return map {$self->lookup($_)} @names;
}


sub guess_region {
    my ($self, $string) = @_;

    my %count = ();
    foreach my $name ($self->names_in($string)) {
        foreach my $region (@{$name->regions}) {
            $count{$region}++;
        }
    }
    
    # TODO: Return nothing if more than one result and same score on two first

    my ($best) = sort {$count{$b} <=> $count{$a}} keys %count;
    return $best;
}


1;
