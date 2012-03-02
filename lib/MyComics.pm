package MyComics;
use Dancer ':syntax';

use MyComics::DB;

our $VERSION = '0.1';

sub db { MyComics::DB->connect( @{ setting( 'db' ) } ) }

get '/' => sub {
    return { application => setting( 'appname' ) };
};

sub format_comic {
    my $comic = shift;

    return {
        id      => $comic->id,
        title   => $comic->title, 
        authors => [ map { $_->name } $comic->authors ]
    }
}

post '/comic' => sub {
    my $title   = param( 'title' );
    my $authors = param( 'authors' );

    my $db = db();

    # Finding or creating authors
    $authors = [ map { 
        $db->resultset( 'Author' )->find_or_create( {
            name => $_,
        } ) 
    } @$authors ];

    # Creating comic
    my $comic = $db->resultset( 'Comic' )->create( {
        title => $title,
    } );

    # Attaching authors to comic
    for ( @$authors ) {
        $db->resultset( 'ComicAuthor' )->create( {
            comic_id  => $comic->id,
            author_id => $_->id,
        } );
    }

    status 201;
    return format_comic( $comic );
};

get '/comic/:id' => sub {
    my $id = param( 'id' );

    my $comic = db->resultset( 'Comic' )->find( 
        { id => $id },
        { prefetch => { comic_author => 'author_id' } },
    );

    return format_comic( $comic );
};

get '/search' => sub {
    my $query = param( 'query' );

    my @comics = db->resultset( 'Comic' )->search(
        { title => { -like => '%' . $query . '%'} },
        { prefetch => { comic_author => 'author_id' } },
    );

    return [ map { format_comic( $_ ) } @comics ];

};

get '/spore-desc' => sub {
    return {
        version => $VERSION,
        name    => setting( 'appname' ),
        methods => {
            add_comic => {
                method => 'POST',
                path   => '/comic',
                expected_status => [ 201 ],
            },
            get_comic => {
                method => 'GET',
                path   => '/comic/:id',
                required_params => [ 'id' ],
                expected_status => [ 200 ],
            },
            search => {
                method => 'GET',
                path   => '/search',
                required_params => [ 'query' ],
                expected_status => [ 200 ],
            },
        },
    };
};

true;
