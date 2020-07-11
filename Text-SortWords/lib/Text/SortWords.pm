package Text::SortWords;

use 5.014;
use strict;
use warnings;

use Moo;

has match_re       => ( is => 'ro', required => 1 );
has prefix_skip_re => (
    is      => 'ro',
    default => sub {
        return qr#\A#ms;
    },
);

sub sort_text_ref
{
    my ( $self, $text_ref ) = @_;

    my $match_re       = $self->match_re();
    my $prefix_skip_re = $self->prefix_skip_re();
    my @matches;

    my $on_match = sub {
        my $m = shift;
        push @matches, $m;
        return $m;
    };

    my $prefix;
    if ( $$text_ref =~ m#${prefix_skip_re}# )
    {
        my $pos = $+[0];
        $prefix = substr( $$text_ref, 0, $pos, '' );
    }

    $$text_ref =~ s#($match_re)#$on_match->($1)#egms;

    @matches = sort @matches;

    $$text_ref =~ s#($match_re)#shift(@matches)#egms;

    if (@matches)
    {
        die "not all matches were placed!";
    }

    $$text_ref = $prefix . $$text_ref;

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

=head2 prefix_skip_re

The regular expression to use in order to skip a prefix before matching words.
Defaults to the no-op regex C<qr/\A/> . (An argument to "new()").

=head2 $sorter->sort_text_ref(\$text);

Sort the matches inside $text while mutating it.

Returns void.

=cut
