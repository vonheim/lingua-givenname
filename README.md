# lingua-givenname
Perl module for identifying given names in text


# SYNOPSIS
  $given_names = Lingua::GivenNames->new;
  @names = $given_names->names_in("This text contains Lynn and Edvard");

  $region = $given_names->guess_region("It is common to be called Ola, Kari, Per and Lars in my home country");
