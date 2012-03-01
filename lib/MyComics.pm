package mycomicsdb;
use Dancer ':syntax';

use MyComics::DB;

our $VERSION = '0.1';

sub db {
    return MyComics::DB->connect( @{ setting( 'db' ) } );
}

get '/' => sub {
    return { application => setting( 'appname' ) };
};

get '/comic/:id' => sub {
    my $id = param( 'id' );

    db->resultset( 'Comic' )->find( $id );    


};

#post '/author' => sub {
#    my 



#}

sub missing {
    my $param = shift;
    send_error( "missing: $param", 400 );
}

get '/spore-desc' => sub {
    return {
        version => $VERSION,
        name    => setting( 'appname' ),
        methods => {

        }
    };
};

true;
