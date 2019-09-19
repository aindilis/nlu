#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;

my $agent = UniLang::Util::TempAgent->new;
my $res = 

print Dumper($agent->MyAgent->QueryAgent
  (
   Receiver => "NLU",
   Data => {
	    Word => "word",
	    Command => "Get Word Senses",
	   },
  ));
