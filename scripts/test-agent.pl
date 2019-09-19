#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;

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
	    File => "/var/lib/myfrdcsa/codebases/minor/nlu/test.txt",
	    # Tests => 1,
	    # Emacs => 1,
	   },
  );

# print Dumper($message);
print $message->Generate();
