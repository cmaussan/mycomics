package MyComics::DB::Result::ComicAuthor;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table( 'comicauthor' );

__PACKAGE__->add_columns(
    comic_id  => { data_type => 'int' },
    author_id => { data_type => 'int' },
);

__PACKAGE__->set_primary_key( qw( comic_id author_id ) );
__PACKAGE__->belongs_to( comic_id  => 'MyComics::DB::Result::Comic' );
__PACKAGE__->belongs_to( author_id => 'MyComics::DB::Result::Author' );

1;

