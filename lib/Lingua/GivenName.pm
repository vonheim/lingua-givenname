package Lingua::GivenName;

use Moose;
use Lingua::GivenName::Storage;
use FindBin;
use File::ShareDir qw(module_dir);


has 'list' => (is=>'rw', isa=>'Lingua::GivenName::List', builder=>'_build_list', lazy=>1);


sub _build_list {
    my ($self) = @_;
    my $storage = Lingua::GivenName::Storage->new;
    my $path = $self->_resolve_path;
    return $storage->load($path);
}


sub _resolve_path {
    my ($self) = @_;

    my $file = 'names.json';
    my $path = "$FindBin::Bin/../data/$file";
    return $path if -e $path;

    return module_dir('Lingua::GivenName') . "/$file";
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
