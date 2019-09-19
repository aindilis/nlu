#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;
use System::KNext;

# take this book, and run the NLU on it, to extract all the
# annotations that are necessary, as though it were being processed on
# workhorse

# have the intersplicing of the annotations done

# just handle the first paragraph for now

my $paragraph = "Another and perhaps even more formidable objection occurs. A history
beset with such distracting problems, bristling with such thorny
controversies, a history, above all, which has so much bearing upon that
portion of history which has still to be born, ought, it may be said, to
be approached in the gravest and most authoritative fashion possible, or
else not approached at all. This is too true, and that so slight a
summary as this can put forward no claim to authority of any sort is
evident enough. National \"stories,\" however, no less than histories,
gain a gravity, it must be remembered, and even at times a solemnity
from their subject apart altogether from their treatment. A good reader
will read a great deal more into them than the mere bald words convey.
The lights and shadows of a great or a tragic past play over their easy
surface, giving it a depth and solidity to which it could otherwise lay
no claim. If the present attempt disposes any one to study at first hand
one of the strangest and most perplexing chapters of human history and
national destiny, its author for one will be more than content.";

my $knext =
  System::KNext->new
  (
   DontFormalize => 1,
   Overwrite => 0,
   ClearSayerCache => 0,
   Debug => 0,
   SplitBy => "every few sentences",
   File => "",
  );

print Dumper($knext->Process(Contents => $paragraph));
