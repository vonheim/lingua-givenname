use inc::Module::Install;

name     'Lingua-GivenName';
all_from 'lib/Lingua/GivenName.pm';


license  'perl';

requires 'Moose' => '2.1209';
requires 'File::Slurp' => '9999.19';
requires 'JSON::XS' => '3.01';
requires 'YAML' => '0.95';
requires 'MooseX::App' => '1.33';

install_script glob('bin/*');

auto_install;

install_share( 
    module => 'Lingua::GivenName' => 'data'
);

WriteAll;
