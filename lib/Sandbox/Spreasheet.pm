package Sandbox::Spreasheet;
use Dancer ':syntax';

use Text::CSV;
use Spreadsheet::HTML;

our $VERSION = '0.01';
our $CSV = Text::CSV->new;

get '/' => sub { template 'index' };

get '/table' => sub {

    my $params = {};
    if (params->{data}) {

        my $data = parse_data( params->{data} );
        my $html = Spreadsheet::HTML->new( data => $data );

        my @args = ();
        my $style = params->{style} || 'generate'; 

        for (qw( matrix tgroups headless layout )) {
            my $val = params->{$_} || '';
            push @args, ( $_ => 1 ) if $val eq 'true';
        }

        $params = { output => $html->$style( @args ) };
    }

    template 'table', $params, { layout => undef };
};


sub parse_data {
    my $lines = shift;
    my @data;
    for (split /\n/, $lines) {
        $CSV->parse( $_ );
        push @data, [ $CSV->fields ];
    }
    return \@data;
}

true;
