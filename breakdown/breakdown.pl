#!/usr/bin/perl -w

# reads in a text and attempts to break it down into subunits

use PerlLib::SwissArmyKnife;
use Breakdown;

foreach my $file (split /\n/, `ls sample-texts`) {
  my $c = read_file("sample-texts/".$file);
  Breakdown(Text => $c);
}

sub Breakdown {
  my (%args) = @_;
  # okay so we are going to want to break the text down into smaller
  # annotations.

  # split it into sentences
  if (! exists $args{Data}->{Sentences}) {
    StandoffGetSentences
      (
       Text => $args{Text},
      );
  }
}
