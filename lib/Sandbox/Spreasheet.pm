package Sandbox::Spreasheet;
use Dancer ':syntax';

use Spreadsheet::HTML;

our $VERSION = '0.1';

get '/' => sub {

    my $params = {};

    if (params->{data}) {
        my $data = eval sprintf "%s", params->{data};
        my $style = params->{style} || 'generate'; 
        my $html = Spreadsheet::HTML->new( data => $data );
        my @args = ();

        $params = { output => $html->$style( @args ) };
    }

    template 'index', $params;
};

true;
