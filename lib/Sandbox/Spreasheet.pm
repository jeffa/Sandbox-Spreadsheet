package Sandbox::Spreasheet;
use Dancer ':syntax';

use Spreadsheet::HTML;

our $VERSION = '0.1';

get '/' => sub {
    my $table = Spreadsheet::HTML->new( data => [['a'..'c'],[1..3],[4..6],[7..9]] );
    template 'index', { table => $table };
};

true;
