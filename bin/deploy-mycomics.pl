#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use MyComics::DB;

my $options = GetOptions(
    'dsn=s'  => \my $dsn,
    'user=s' => \my $user,
    'pass=s' => \my $pass,
);

die "--dsn undef!" unless $dsn;

my $mycomics = MyComics::DB->connect( $dsn, $user, $pass );

$mycomics->deploy;
