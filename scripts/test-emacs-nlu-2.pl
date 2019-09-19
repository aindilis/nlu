#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;

my $tempagent = UniLang::Util::TempAgent->new();

my $file = "/var/lib/myfrdcsa/codebases/minor/nlu/test.txt";
my $c = read_file($file);

my $message = $tempagent->MyAgent->QueryAgent
  (
   Receiver => "NLU",
   Contents => "",
   'Data' => {
	      'Light' => 1,
	      'All' => 1,
	      'Emacs' => 1,
	      'Start' => 0,
	      'Database' => 'freekbs2',
	      'End' => 504,
	      '_DoNotLog' => 1,
	      'File' => '/var/lib/myfrdcsa/codebases/minor/nlu/frdcsa/emacs/nlu-sample.txt',
	      'Run' => 1,
	      'Context' => 'Org::FRDCSA::NLU::Buffer::Ghost of temp'
	     },
   # Data => {
   # 	    Database => "freekbs2",
   # 	    Context => "Org::FRDCSA::NLU::Temp",
   # 	    All => 1,
   # 	    Run => 1,
   # 	    File => $file,
   # 	    Emacs => 1,
   # 	    Start => 0,
   # 	    End => length($c),
   # 	    Light => 1,
   # 	   }
   ,
  );

# print Dumper($message);
print $message->Generate();
