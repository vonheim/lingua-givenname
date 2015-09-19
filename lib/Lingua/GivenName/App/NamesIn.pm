package Lingua::GivenName::App::NamesIn;



use MooseX::App::Command;
use Lingua::GivenName::Storage;
use Lingua::GivenName::List;
use Lingua::GivenName;

extends qw(Lingua::GivenName::App);

command_short_description 'Read text from STDIN. Output info about names to STDOUT.';


sub run {
    my ($self) = @_;

    my $given_name = Lingua::GivenName->new;
    my $text = join '', <STDIN>;

    my @names = $given_name->names_in($text);
    foreach my $name (@names) {
        print $name->as_string,"\n";
    }
}


1;
