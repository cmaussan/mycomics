package MyComics::DB::Result::Comic;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table( 'comic' );

__PACKAGE__->add_columns(
    id     => { data_type => 'int', is_autoincrement => 1 },
    title  => { data_type => 'varchar' },
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->has_many( comic_author => 'MyComics::DB::Result::ComicAuthor', 'comic_id' );
__PACKAGE__->many_to_many( authors => 'comic_author', 'author_id' );


1;

