package Sandbox::Spreasheet;
use Dancer ':syntax';

use Safe;
use Text::CSV;
use lib '/Users/jeffa/code/Spreadsheet-HTML/lib';
use Spreadsheet::HTML;

our $VERSION = '0.01';
our $CSV = Text::CSV->new;
our $SAFE = Safe->new;

get '/' => sub { template 'index' };

get '/table' => sub {

    my $params = {};
    my $data = parse_data( params->{data} );
    my $html = Spreadsheet::HTML->new( data => $data );

    my @args = ();
    my $style = params->{style} || 'generate'; 

    for (qw( matrix tgroups headless flip pinhead )) {
        my $val = params->{$_} || '';
        push @args, ( $_ => 1 ) if $val eq 'true';
    }

    for (qw( theta indent encodes caption empty )) {
        my $val = params->{$_};
        next unless length $val;
        $val = undef if $val eq 'undef';
        $val = '' if $val eq "''";
        push @args, ( $_ => $val );
    }

    if (my $any = params->{any}) {
        push @args, ( $SAFE->reval( $any ) );
    }

    $params = {
        command => "\$object->$style( @args )",
        output  => $html->$style( @args ),
    };

    template 'table', $params, { layout => undef };
};


sub parse_data {
    my $lines = shift;
    my @data;
    for (split /\n/, $lines) {
        $CSV->parse( $_ );
        push @data, [ map { /([^.]+)\.\.(.*)/ ? ( $1 .. $2 ) : $_ } $CSV->fields ];
    }
    return \@data;
}

true;
