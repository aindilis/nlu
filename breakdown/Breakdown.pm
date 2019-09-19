package Breakdown;

require Exporter;
@ISA = qw(Exporter);

@EXPORT = qw (StandoffGetSentences);

use PerlLib::SwissArmyKnife;

use Lingua::EN::Sentence qw(get_sentences);

sub StandoffGetSentences {
  my %args = @_;
  MatchObjects
    (
     Text => $args{Text},
     Objects => get_sentences($args{Text}),
    );
}

sub MatchObjects {
  my (%args) = @_;
  print Dumper(\%args);
}

1;
