package MyComics::DB::Result::Comic;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table( 'comic' );

__PACKAGE__->add_columns(
    id     => { data_type => 'int', is_autoincrement => 1 },
    title  => { data_type => 'varchar' },
    lang   => { data_type => 'varchar' },
    editor => { data_type => 'varchar' },
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->belongs_to( author => 'MyComics::DB::Result::Author', 'id' );

1;

