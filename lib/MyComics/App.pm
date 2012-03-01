package MyComics::App;

use 5.010;

use Moose;
use Net::HTTP::Spore;
use Try::Tiny;
use YAML;

with 'MooseX::Getopt';

has 'base_url' => ( is => 'ro', isa => 'Str', required => 1, documentation => "SPORE API base url" );
has 'spec'     => ( is => 'ro', isa => 'Str', required => 1, documentation => "SPORE spec location" );

has '_spore' => (
    is  => 'ro',
    isa => 'Object',
    required => 1,
    lazy => 1,
    default => sub {
        my $self   = shift;
        my $client = Net::HTTP::Spore->new_from_spec(
            $self->spec,
            base_url => $self->{ base_url },
        );
        $client->enable( 'Format::JSON' );
        $client;
    }

);

sub add_comic {
    my $self = shift;
    my ( $title, @authors ) = @_;

    my ( $res, $error );

    try {
        $res = $self->_spore->add_comic( payload => {
            title   => $title,
            authors => \@authors,
        } )->body;
    }
    catch { $error = $_ };
    die "ERROR: " . Dump( $error ) if( $error );

    say Dump $res;

}

sub get_comic {
    my $self = shift;
    my ( $id ) = @_;

    my ( $res, $error );

    try {
        $res = $self->_spore->get_comic( id => $id )->body;
    }
    catch { $error = $_ };
    die "ERROR: " . Dump( $error ) if( $error );

    say Dump $res;   
}

sub search {
    my $self = shift;
    my ( $query ) = @_;

    my ( $res, $error );

    try {
        $res = $self->_spore->search( query => $query )->body;
    }
    catch { $error = $_ };
    die "ERROR: " . Dump( $error ) if( $error );

    say Dump $res;
}


1;
