package NLU;

# ("created-by" "PPI-Convert-Script-To-Module")

use BOSS::Config;
use Capability::TextAnalysis;
use Data::Dumper;
use KBS2::Client;
use KBS2::ImportExport;
use PerlLib::Dictionary;
use PerlLib::SwissArmyKnife;
use Sayer;

use WordNet::QueryData;

use utf8;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyClient MyConfig Context Conf Database Implications Patterns
   Resources Sayer1 Sayer2 MyTextAnalysis AllAssertedKnowledge
   SkipKBS2 MyWordNet Debug /

  ];

sub init {
  my ($self,%args) = @_;
  my $specification = "
	-c <context>	The context to use

	--start <pos>	The starting offset of the text
	--end <pos>	The ending offset of the text

	--clear		Clear the context of Sayer

	--emacs		Output emacs data
	--prolog	Output prolog data

	-f <file>	File to process
	-r		Run the processing

	--all		Perform all processing

	--pp		Process Patterns
	--pw		Process WSD

	-t		Run the tests

	-p		Print the domain

	--skip-kbs2	Don't use KBS2

	-u [<host> <port>]	Run as a UniLang agent

	-w			Require user input before exiting
";

  $self->Debug(1);

  $self->MyConfig
    (BOSS::Config->new
     (Spec => $specification));
  $self->Conf($self->MyConfig->CLIConfig);
  # $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";
  if (exists $self->Conf->{'-u'}) {
    $UNIVERSAL::agent->Register
      (Host => defined $self->Conf->{-u}->{'<host>'} ?
       $self->Conf->{-u}->{'<host>'} : "localhost",
       Port => defined $self->Conf->{-u}->{'<port>'} ?
       $self->Conf->{-u}->{'<port>'} : "9000");
  }
  $self->AllAssertedKnowledge({});
  $self->SkipKBS2(1); # $conf->{'--skip-kbs2'});
  $self->Sayer1
    (Sayer->new
     (
      DBName => "sayer_nlu",
     ));
  $self->Sayer2
    (Sayer->new
     (
      DBName => "sayer_nlu_textanalysis",
     ));
  $self->MyTextAnalysis
    (Capability::TextAnalysis->new
     (
      Sayer => $self->Sayer2,
      Skip => {
	       "SemanticAnnotation" => 1,
	       "CycLsForNP" => 1,
	       "CoreferenceResolution" => 1,
	       "SpeechActClassification" => 1,
	      },
      # DontSkip => {
      # 		   "NamedEntityRecognition" => 1,
      # 		  },
     ));
  $self->Resources
    ({});
  $self->Patterns
    ({
      "Whitespace" => {
		       Regex => [qr/\b\s+\b/],
		       Triggers => [],
		      },
      "Space" => {
		  Regex => [qr/\b\s\b/],
		  Triggers => [],
		 },
      "Closing period" => {
			   Regex => [qr/\b\.\s?/],
			   Triggers => [],
			  },
      "Alpha-numeric String" => {
				 Regex => [qr/\b\w+\b/],
				 Triggers => [
					      # test if it is a dictionary word
					      sub {
						my %args = @_;
						if (! $self->Resources->{Dictionary}) {
						  $self->Resources->{Dictionary} = PerlLib::Dictionary->new
						    (
						     CaseSensitive => 0,
						    );
						}
						my $entry = ["has-dictionary-entry", ["dictionary-fn", "PerlLib::Dictionary", "English"], $args{Substring}];
						if ($self->Resources->{Dictionary}->Lookup(Word => $args{Substring})) {
						  $self->Assert($entry);
						} else {
						  $self->Assert(["not",$entry]);
						}
					      },
					     ],
				},
     });
  $self->Implications
    ([
      ["implies",
       ["and",
	["matches-pattern", \*{'::?X'}, "Alpha-numeric String"],
	["has-string", \*{'::?X'}, \*{'::?Y'}],
	["has-dictionary-entry", ["dictionary-fn", "PerlLib::Dictionary", "English"], \*{'::?Y'}],
       ],
       ["derived-possibility", \*{'::?X'}, "English Word"],
      ],
     ]);
}

sub Execute {
  my ($self,%args) = @_;
  my $conf = $self->MyConfig->CLIConfig;
  if (exists $conf->{'-u'}) {
    # enter in to a listening loop
    while (1) {
      $UNIVERSAL::agent->Listen(TimeOut => 10);
    }
  }
  if (exists $conf->{'-w'}) {
    Message(Message => "Press any key to quit...");
    my $t = <STDIN>;
  }
}

sub ProcessMessage {
  my ($self,%args) = @_;
  my $m = $args{Message};
  print Dumper($m);		# UniLang::Util::Message

  # look at the data segment and send
  my $it = $m->Contents;
  if ($it =~ /^echo\s*(.*)/) {
    $UNIVERSAL::agent->SendContents
      (Contents => $1,
       Receiver => $m->{Sender});
  } elsif ($it =~ /^(quit|exit)$/i) {
    $UNIVERSAL::agent->Deregister;
    exit(0);
  }
  my $d = $m->Data;
  my $res;
  if (exists $d->{Command}) {
    if ($d->{Command} eq "Get Word Senses") {
      $res = $self->GetWordSenses
	(
	 Word => $d->{Word},
	);
    } elsif ($d->{Command} eq "Convert Text Properties To Inline") {
      $res = $self->ConvertTextPropertiesToInline
	(
	 Properties => $d->{Properties},
	);
    }
  } else {
    # Clear Run File Tests Emacs
    $res = $self->Process
      (
       Context => $d->{Context},
       Database => $d->{Database},
       Run => $d->{Run},
       Clear => $d->{Clear},
       File => $d->{File},
       Tests => $d->{Tests},
       Emacs => $d->{Emacs},
       Start => $d->{Start},
       End => $d->{End},
       All => $d->{All},
       PP => $d->{PP},
       PW => $d->{PW},
       Light => $d->{Light},
      );
  }
  my $result = "";
  if ($res->{Success}) {
    $result = $res->{Result}
  }
  $self->ReturnAnswer
    (
     # QueryAgentReply => 1,
     Result => {Result => $result},
     Message => $m,
    );
}

sub Process {
  my ($self,%args) = @_;
  See(\%args);
  $self->Context
    ($args{Context} || $self->Conf->{'-c'} || "Org::FRDCSA::NLU::Test");
  $self->Database
    ($args{Database} || "freekbs2");
  if (! $self->SkipKBS2) {
    $self->MyClient
      (KBS2::Client->new
       (
	Context => $self->Context,
	Database => $self->Database,
       ));
  }
  if ($args{Clear} || exists $self->Conf->{'--clear'}) {
    # clear the context
    $self->Sayer1->ClearCache();
    $self->Sayer2->ClearCache();
  }
  my $textanalysisresult;
  if ($args{Run} || exists $self->Conf->{'-r'}) {
    if ($self->SkipKBS2) {
      $self->AllAssertedKnowledge->{$self->Context} = [];
    } else {
      $self->MyClient->ClearContext
	(
	 Context => $self->Context,
	 Database => $self->Database,
	);
    }
    my $contents = read_file($args{File} || $self->Conf->{'-f'}, binmode => ':utf8');
    foreach my $implication (@{$self->Implications}) {
      $self->Assert($implication);
    }
    my $result = $self->ProcessData
      (
       Data => [$contents],
       All => $args{All},
       PP => $args{PP},
       PW => $args{PW},
       Light => $args{Light},
      );
    $textanalysisresult = $result->{TextAnalysisResult};
  }
  if ($args{Tests} || exists $self->Conf->{'-t'}) {
    $self->Tests();
  }
  my $assertions;
  if ($self->SkipKBS2) {
    $assertions = $self->AllAssertedKnowledge->{$self->Context};
    print Dumper({Assertions => $assertions}) if $self->Debug > 3;
  } else {
    my $message = $self->MyClient->Send
      (
       QueryAgent => 1,
       Command => "all-asserted-knowledge",
       Context => $self->Context,
      );
    # print Dumper($message);
    if (defined $message) {
      $assertions = $message->{Data}->{Result};
    }
  }
  my $importexport = KBS2::ImportExport->new();
  if ($args{Prolog} || $self->Conf->{'--prolog'}) {
    foreach my $assertion (@$assertions) {
      my $res = $importexport->Convert(Input => [$assertion], InputType => "Interlingua", OutputType => "Prolog");
      # print Dumper({Res => $res});
      if ($res->{Success}) {
	push @prolog, $res->{Output};
      }
    }
    my $result = join("\n",@prolog);
    return {
	    Success => 1,
	    Result => $result,
	   };
  } elsif ($args{Emacs} || $self->Conf->{'--emacs'}) {
    my @tags;
    my $start = $args{Start} || $self->Conf->{'--start'};

    foreach my $assertion (@$assertions) {
      if ($assertion->[0] =~ /^(word-sense-disambiguation|matches-pattern|noun-phrase|timex3-date|has-string)$/) {
	my $converted = $importexport->Convert(Input => [$assertion], InputType => "Interlingua", OutputType => "Emacs String");
	push @tags, "'(".$assertion->[1]->[2]." ".$assertion->[1]->[3]." '".$converted->{Output}.")";
      }
    }
    my $result = "(nlu-add-spanlist ".$start." (list ".join(" ", @tags)."))";

    WriteToTempFile
      (
       Pattern => '/tmp/nlu-results-XXXXXXXX',
       Contents => Dumper({Assertions => $assertions}),
      );

    return {
	    Success => 1,
	    Result => $result,
	   };
  } else {
    return {
	    Success => 1,
	    Result => {
		       Assertions => $assertions,
		       TextAnalysisResult => $textanalysisresult,
		      },
	   };
  }
}

sub ProcessData {
  my ($self,%args) = @_;
  my $data = $args{Data};
  # get a data id from sayer for this, then begin asserting relationships
  # build an index for the data table
  my $ref = ref $data;
  my @textanalysisresults;
  if ($ref ne "ARRAY") {
    print "ERROR: must be an array reference\n";
  } else {
    # get a sayer reference for this data
    my $id = $self->Sayer1->AddData(Data => $data);
    my $entryfn = ["entry-fn", "sayer", $id];
    my $count = scalar @$data;
    # first assert what type of item it is
    $self->Assert(["has-entry-count",$entryfn,$count]);
    my $i = 0;
    foreach my $entry (@$data) {
      my $ref2 = ref $entry;
      if ($ref2 eq "") {
	$self->Assert(["has-ref-type",["array-element", $entryfn, $i],"SCALAR"]);
	# go ahead and process scalar
	my $res = $self->ProcessScalar
	  (
	   All => $args{All},
	   PP => $args{PP},
	   PW => $args{PW},
	   Scalar => $entry,
	   Index => $i,
	   EntryFn => $entryfn,
	   Light => $args{Light},
	  );
	push @textanalysisresults, $res->{TextAnalysisResult};
      } else {
	$self->Assert(["has-ref-type",["array-element", $entryfn, $i],$ref2]);
      }
      ++$i;
    }
  }
  return {
	  TextAnalysisResult => \@textanalysisresults,
	 };
}

sub ProcessScalar {
  my ($self,%args) = @_;

  # here's what I am supposed to do with this, run those tests on
  # every substring, if we know that certain tests are going to fail,
  # avoid running them

  # for now iterate over every substring
  my $scalar = $args{Scalar};
  print Dumper({Scalar => $scalar}) if $self->Debug;
  my $length = length($scalar);
  my $arrayelement = ["array-element", $args{EntryFn}, $args{Index}];
  $self->Assert(["has-length",$arrayelement,$length]);

  if ($args{All} or $self->Conf->{'--all'} or $args{PP} or $self->Conf->{'--pp'}) {
    # extract out visible surface patterns
    foreach my $pattern (keys %{$self->Patterns}) {
      foreach my $regex (@{$self->Patterns->{$pattern}->{Regex}}) {
	my @all = $scalar =~ /(.*?)($regex)(.*?)/sg;
	# print Dumper({All => \@all});
	my $total = 0;
	while (@all) {
	  my ($a,$b,$c) = (shift @all, shift @all, shift @all);
	  $total += length($a);
	  $start = $total;
	  $total += length($b);
	  $end = $total;
	  $total += length($c);
	  my $substr = substr($scalar,$start,$end-$start);
	  # print Dumper([$start,$end,$substr,$pattern])."\n";
	  $self->Assert(["has-string", ["substring-of",$arrayelement,$start,$end], $substr]);
	  $self->Assert(["matches-pattern", ["substring-of",$arrayelement,$start,$end], $pattern]);
	  foreach my $trigger (@{$self->Patterns->{$pattern}->{Triggers}}) {
	    $trigger->(
		       Substring => $substr,
		       Start => $start,
		       End => $end,
		       Pattern => $pattern,
		       ArrayElement => $arrayelement,
		       EntryFn => $args{EntryFn},
		      );
	  }
	}
      }
    }
  }

  my $textanalysisresult;
  if ($args{All} or $self->Conf->{'--all'} or $args{PW} or $self->Conf->{'--pw'}) {
    print "Perform textanalysis\n" if $self->Debug;
    print Dumper({Text => $scalar}) if $self->Debug;
    $textanalysisresult = $self->MyTextAnalysis->ProcessText
      (
       Text => $scalar,
       Light => $args{Light},
       Overwrite => {
		     # '_ALL' => 1,
		    },
       Debug => $self->Debug,
      );
    print Dumper({TextAnalysisResult => $textanalysisresult}) if $self->Debug;
    $self->ProcessWSD
      (
       Results => $textanalysisresult,
       Scalar => $scalar,
       ArrayElement => $arrayelement,
      );
    $self->ProcessNounPhraseExtraction
      (
       Results => $textanalysisresult,
       Scalar => $scalar,
       ArrayElement => $arrayelement,
      );
#     $self->ProcessGetDatesTIMEX3
#       (
#        Results => $textanalysisresult,
#        Scalar => $scalar,
#        ArrayElement => $arrayelement,
#       );
    $self->ProcessOther
      (
       Results => $textanalysisresult,
       Scalar => $scalar,
       ArrayElement => $arrayelement,
      );
  }

  if ($args{All} or $self->Conf->{'--all'} or $args{PPerl} or $self->Conf->{'--pperl'}) {
    # perform perl analysis

  }
  return {
	  TextAnalysisResult => $textanalysisresult,
	 };
}

sub Assert {
  my ($self,$ref) = @_;
  if ($self->SkipKBS2) {
    if (! exists $self->AllAssertedKnowledge->{$self->Context}) {
      $self->AllAssertedKnowledge->{$self->Context} = [];
    }
    push @{$self->AllAssertedKnowledge->{$self->Context}}, $ref;
  } else {
    my $res = $self->MyClient->Send
      (
       Assert => [$ref],
       InputType => "Interlingua",
       Database => $self->Database,
       Context => $self->Context,
       QueryAgent => 1,
       Flags => {
		 AssertWithoutCheckingConsistency => 1,
		},
      );
    return $res;
  }
}

sub Query {
  my ($self,$ref) = @_;
  if ($self->SkipKBS2) {
    print "ERROR: Cannot query when Skipping KBS2\n";
  } else {
    my $res = $self->MyClient->Send
      (
       Query => [$ref],
       Type => "Models",
       InputType => "Interlingua",
       Database => $self->Database,
       Context => $self->Context,
       QueryAgent => 1,
      );
    return $res;
  }
}

sub Tests {
  my ($self,%args) = @_;
  # print Dumper(Query(["has-dictionary-entry", \*{'::?X'}, \*{'::?Y'}]));
  print Dumper($self->Query(["derived-possibility", \*{'::?X'}, "English Word"]));
  #   print Dumper(
  # 	       Query(
  # 		     ["and",
  # 		      ["matches-pattern", \*{'::?X'}, "Alpha-numeric String"],
  # 		      ["has-string", \*{'::?X'}, \*{'::?Y'}],
  # 		      ["has-dictionary-entry", ["dictionary-fn", "PerlLib::Dictionary", "English"], \*{'::?Y'}],
  # 		     ]
  # 		    )
  # 	      );
}

sub ProcessWSD {
  my ($self,%args) = @_;
  my $WSD = $args{Results}->{WSD};
  my $text = $args{Scalar};

  my $length = length($text);
  my $chars = [split //, $text];
  my $pos = 0;

  print Dumper
    ({
      WSD => $WSD,
      Text => $text,
      Args => $args{ArrayElement},
     });

  foreach my $entry (@{$WSD->[0]}) {
    my $ref = ref $entry;
    if ($ref eq "ARRAY") {
      foreach my $entry2 (@$entry) {
	my $word = $entry2->{Word};
	# print $word." ";
	my $chars2 = [split //, $word];
	# extract out the position of the next word
	my $length2 = length($word);
	my $pos2 = 0;
	my $start;
	my $end;
	my $complete = 0;
	while (! $complete) {
	  if ($chars->[$pos] eq $chars2->[$pos2]) {
	    if (! defined $start) {
	      $start = $pos;
	    }
	    ++$pos;
	    ++$pos2;
	    if ($pos >= $length or $pos2 >= $length2) {
	      # print out the position
	      $complete = 1;
	      $end = $pos;
	      # print Dumper([$start,$end,$word]);
	      my $item = ["substring-of",$args{ArrayElement},$start,$end];
	      my $wqd = $entry2->{WQD};
	      $wqd =~ s/\#.*//;
	      $self->Assert(["word-sense-disambiguation", $item, "Pedersen", ["wordnet-sense", $wqd, $entry2->{POS}, $entry2->{Sense}]]);
	    }
	  } else {
	    ++$pos;
	  }
	}
      }
    } else {
      # FIXME: IF YOU ARE GETTING WSD ERRORS, maybe it's because of
      # the cutoff.  Have to forward the position by the sentence that
      # returned a "" instead of WSD results.
    }
  }
}

sub ProcessNounPhraseExtraction {
  my ($self,%args) = @_;
  my $npe = $args{Results}->{NounPhraseExtraction};
  my $scalar = $args{Scalar};
  print Dumper({Scalar => $scalar}) if $self->Debug > 3;
  foreach my $phrase (@$npe) {
    next if $phrase == 1;
    print "<$phrase>\n";
    if (0) {
      my @all = $scalar =~ /(.*?)\b(\Q$phrase\E)\b(.*?)/isg;
      print Dumper({All => \@all}) if $self->Debug > 3;
      my $total = 0;
      while (@all) {
	my ($a,$b,$c) = (shift @all, shift @all, shift @all);
	$total += length($a);
	$start = $total;
	$total += length($b);
	$end = $total;
	$total += length($c);
	my $substr = substr($scalar,$start,$end-$start);
	# print Dumper([$start,$end,$substr,$pattern])."\n";
	my $statement = ["noun-phrase", ["substring-of",$args{ArrayElement},$start,$end], $substr];
	# print Dumper($statement);
	$self->Assert($statement);
      }
    } else {
      my $scalarcopy = $scalar;
      my $loop = 1;
      my $total = 0;
      while ($loop) {
	my $regex = $phrase;
	$regex =~ s/[^_A-Za-z0-9-]/\./sg;
	if ($scalarcopy =~ /^(.*?)\b($regex)\b/isg) {
	  my ($a, $b) = ($1, $2);

	  $total += length($a);
	  my $subtotal += length($a);
	  my $start = $total;
	  $total += length($b);
	  $subtotal += length($b);
	  my $end = $total;

	  $scalarcopy = substr($scalarcopy, $subtotal);
	  my $statement = ["noun-phrase", ["substring-of",$args{ArrayElement},$start,$end], $b];
	  $self->Assert($statement);
	} else {
	  $loop = 0;
	}
      }
    }
  }
}

sub ProcessGetDatesTIMEX3 {
  my ($self,%args) = @_;
  my $dates = $args{Results}->{GetDatesTIMEX3};
  my $scalar = $args{Scalar};
  foreach my $entry (@$dates) {
    foreach my $date (keys %{$entry->{Dates}}) {
      foreach my $key (keys %{$entry->{Dates}->{$date}}) {
	my $datetext = $entry->{Dates}->{$date}->{$key}->{DateText};
	my @all = $scalar =~ /(.*?)\b($datetext)\b(.*?)/sg;
	# print Dumper({All => \@all});
	my $total = 0;
	while (@all) {
	  my ($a,$b,$c) = (shift @all, shift @all, shift @all);
	  $total += length($a);
	  $start = $total;
	  $total += length($b);
	  $end = $total;
	  $total += length($c);
	  my $substr = substr($scalar,$start,$end-$start);
	  # print Dumper([$start,$end,$substr,$pattern])."\n";
	  my $statement = ["timex3-date", ["substring-of",$args{ArrayElement},$start,$end], $substr];
	  # print Dumper($statement);
	  $self->Assert($statement);
	}
      }
    }
  }
}

sub ProcessOther {
  my ($self,%args) = @_;
  print Dumper($args{Results});
}

sub PrintDomain {
  my ($self,%args) = @_;
  system "kbs2 --db ".shell_quote($self->Database)." -c ".shell_quote($self->Context)." show | sort";
}

sub ReturnAnswer {
  my ($self,%args) = @_;
  $UNIVERSAL::agent->QueryAgentReply
    (
     Message => $args{Message},
     Data => {
	      _DoNotLog => 1,
	      Result => $args{Result}->{Result},
	     },
    );
}

sub GetWordSenses {
  my ($self,%args) = @_;
  if (! defined $self->MyWordNet) {
    $self->MyWordNet
      (WordNet::QueryData->new(noload => 1));
  }
  my @items;
  if (exists $args{POS}) {
    @items = $self->MyWordNet->querySense($args{Word}."#".$args{POS});
  } else {
    foreach my $sense ($self->MyWordNet->querySense($args{Word})) {
      push @items, $self->MyWordNet->querySense($sense);
    }
  }
  my $results = {};
  foreach my $item (@items) {
    $results->{$item} = [$self->MyWordNet->querySense($item,"glos")]->[0];
  }
  return {
	  Success => 1,
	  Result => $results,
	 };
}

sub ConvertTextPropertiesToInline {
  my ($self,%args) = @_;
  print Dumper(\%args);
  return "";
}

1;
