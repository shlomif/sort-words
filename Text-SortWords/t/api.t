#!/usr/bin/env perl

use 5.014;
use strict;
use warnings;
use Test::More tests => 2;

use Text::SortWords ();

{
    my $obj = Text::SortWords->new(
        {
            match_re => qr/[A-Za-z0-9_\-]+/,
        }
    );

    # TEST
    ok( $obj, "An object was instantiated" );

    my $SPACE1 = " \t ";
    my $SPACE2 = "  ";
    my $SPACE3 = "\t\t";
    my $SPACE4 = "==";

    my $INPUT_STRING = "the"
        . $SPACE1 . "quick"
        . $SPACE2 . "brown"
        . $SPACE3 . "fox"
        . $SPACE4;
    my $WANT_STRING = "brown"
        . $SPACE1 . "fox"
        . $SPACE2 . "quick"
        . $SPACE3 . "the"
        . $SPACE4;
    my $s = '' . $INPUT_STRING . '';
    $obj->sort_text_ref( \$s );

    # TEST
    is( $s, $WANT_STRING, "sort_text_ref() simple test", );
}
