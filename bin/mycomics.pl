#!/usr/bin/env perl

use strict;
use warnings;

use 5.010;

use MyComics::App;
use YAML;

my $app  = MyComics::App->new_with_options();
my @args = @{ $app->extra_argv };
my $verb = shift @args;

die( "ERROR: '$verb' is not a valid action\n" ) 
    unless( $app->meta->find_method_by_name( $verb ) );

$app->$verb( @args );
