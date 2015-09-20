package Lingua::GivenName::App::GuessRegion;

use MooseX::App::Command;
use Lingua::GivenName;

extends qw(Lingua::GivenName::App);

command_short_description 'Read text from STDIN. Output region to STDOUT.';


sub run {
    my ($self) = @_;

    my $given_name = Lingua::GivenName->new;
    my $text = join '', <STDIN>;

    my $region = $given_name->guess_region($text);
    print $region ? "$region\n" : "Could not guess.\n";
}


1;
