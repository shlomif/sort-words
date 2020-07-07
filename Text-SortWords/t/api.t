#!/usr/bin/env perl

use 5.014;
use strict;
use warnings;
use Test::More tests => 1;

use Text::SortWords ();

{
    my $obj = Text::SortWords->new(
        {
            match_re => qr/[A-Za-z0-9_\-]+/,
        }
    );

    # TEST
    ok( $obj, "An object was instantiated" );
}
