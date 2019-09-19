#!/usr/bin/perl -w

use NLU::Util::AnnotationStyle;
use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;
use System::KNext;

# take this book, and run the NLU on it, to extract all the
# annotations that are necessary, as though it were being processed on
# workhorse

# have the intersplicing of the annotations done

# just handle the first paragraph for now

my $paragraph = "This superfluity of bogs seems always in earlier times to have been
expeditiously set down by all historians and agriculturists as part of
the general depravity of the Irish native, who had allowed his good
lands,--doubtless for his own mischievous pleasure--to run to waste;
bogs being then supposed to differ from other lands only so far as they
were made \"waste and barren by superfluous moisture.\" About the middle
of last century it began to be perceived that this view of the matter
was somewhat inadequate; the theory then prevailing being that bogs owed
their origin not to water alone, but to the destruction of woods, whose
remains are found imbedded in them--a view which held good for another
fifty or sixty years, until it was in its turn effectually disposed of
by the report of the Bogs Commission in 1810, when it was proved once
for all that it was to the growth of sphagnums and other peat-producing
mosses they were in the main due--a view which has never since been
called in question.";

my $tmpfile = "/tmp/kuranatron.txt";

# send to the NLU for analysis
my $fh = IO::File->new();
$fh->open(">$tmpfile");
print $fh $paragraph;
$fh->close();

my $tempagent = UniLang::Util::TempAgent->new();

my $message = $tempagent->MyAgent->QueryAgent
  (
   Receiver => "NLU",
   Contents => "",
   Data => {
	    Database => "freekbs2",
	    Context => "Org::FRDCSA::NLU::Temp",
	    All => 1,
	    Run => 1,
	    # Clear => 1,
	    File => $tmpfile,
	    # Tests => 1,
	    # Emacs => 1,
	   },
  );

# print Dumper($message);
print $message->Generate();
