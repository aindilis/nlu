#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;

my $tempagent = UniLang::Util::TempAgent->new;
my $message = $tempagent->MyAgent->QueryAgent
  (
   Receiver => "NLU",
   Data => {
	    "_DoNotLog" => 1,
	    Command => "Get Word Senses",
	    Word => "basic",
	   },
  );

print Dumper($message);
