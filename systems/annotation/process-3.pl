#!/usr/bin/perl -w

use BOSS::Config;
use NLU::Util::AnnotationStyle;
use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;

use Text::Fracture qw(init fract);

# take this book, and run the NLU on it, to extract all the
# annotations that are necessary, as though it were being processed on
# workhorse

# have the intersplicing of the annotations done

# just handle the first paragraph for now

$specification = q(
	-W [<delay>]		Exit as soon as possible (with optional delay)
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

# my $book = read_file("/var/lib/myfrdcsa/codebases/minor-data/nlu/Calendar of the State Papers Relating to Ireland, of the Reigns of Henry VIII, Edward VI., Mary, and - Great Britain. Public Record Office.txt");

init({ max_lines => 20, max_cpl => 300, max_chars => 2000 });
my $text = read_file("/var/lib/myfrdcsa/codebases/minor-data/nlu/Calendar of the State Papers Relating to Ireland, of the Reigns of Henry VIII, Edward VI., Mary, and - Great Britain. Public Record Office.txt");
my $aref = fract($text);

my @fragments;
foreach my $fragment (@$aref) {
  # come up with a system for annotated with respect to a different text
  AnalyzeFragment
    (
     Text => substr($text,$fragment->[0],$fragment->[1]),
     Offset => $fragment->[0],
    );
  if ($conf->{'-W'}) {
    exit(0);
  }
}

print join("\n************************\n",@fragments);

# split the book into paragraphs, and then perform the NLU analysis on
# the paragraphs with the offsets marked

sub AnalyzeFragment {
  my %args = @_;
  my $tmpfile = "/tmp/kuranatron.txt";
  SafelyRemove
    (
     Items => [$tmpfile],
     AutoApprove => 1,
    );

  # send to the NLU for analysis
  my $fh = IO::File->new();
  $fh->open(">$tmpfile");
  print $fh $args{Text};
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
	      Start => $args{Offset},
	      # Tests => 1,
	      # Emacs => 1,
	     },
    );

  # print Dumper($message);
  print $message->Generate();
  # GetSignalFromUserToProceed();
}
