package Text::SortWords;

use 5.014;
use strict;
use warnings;

use Moo;

has match_re => ( is => 'ro', required => 1 );

sub sort_text_ref
{
    my ( $self, $text_ref ) = @_;

    my $match_re = $self->match_re();
    my @matches;

    my $on_match = sub {
        my $m = shift;
        push @matches, $m;
        return $m;
    };

    $$text_ref =~ s#($match_re)#$on_match->($1)#egms;

    @matches = sort @matches;

    $$text_ref =~ s#($match_re)#shift(@matches)#egms;

    if (@matches)
    {
        die "not all matches were placed!";
    }

    return;
}
1;

__END__

=encoding utf8

=head1 NAME

Text::SortWords - sort individual "words" in a text while preserving separators/delimiters .

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 match_re

The regular expression to use in order to match words (a required argument to "new()".

=head2 $sorter->sort_text_ref(\$text);

Sort the matches inside $text while mutating it.

Returns void.

=cut
