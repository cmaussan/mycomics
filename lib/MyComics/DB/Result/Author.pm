package MyComics::DB::Result::Author;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table( 'author' );

__PACKAGE__->add_columns(
    id   => { data_type => 'int', is_autoincrement => 1 },
    name => { data_type => 'varchar' },
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->has_many( comics => 'MyComics::DB::Result::Comic', 'id' );

1;

