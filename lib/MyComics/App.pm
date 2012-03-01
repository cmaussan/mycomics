package MyComics::App;

use 5.010;

use Moose;
use Net::HTTP::Spore;
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

sub add {
    my $self = shift;
    say Dump \@_;

}


1;
