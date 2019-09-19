#!/usr/bin/perl -w

use Capability::TextAnalysis;
use KBS2::Client;
use KBS2::ImportExport;
use PerlLib::SwissArmyKnife;
use Sayer;

use PerlLib::Dictionary;

#!/usr/bin/perl -w

use BOSS::Config;

use Data::Dumper;

$specification = "
	-c <context>	The context to use

	--start <pos>	The starting offset of the text
	--end <pos>	The ending offset of the text

	--clear		Clear the context of Sayer
	--emacs		Output emacs data

	-f <file>	File to process
	-r		Run the processing

	--all		Perform all processing

	--pp		Process Patterns
	--pw		Process WSD

	-t		Run the tests

	-p		Print the domain

	-u [<host> <port>]	Run as a UniLang agent

	-w			Require user input before exiting
";


my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

if (exists $conf->{'-u'}) {
  $agent->Register
    (Host => defined $conf->{-u}->{'<host>'} ?
     $conf->{-u}->{'<host>'} : "localhost",
     Port => defined $conf->{-u}->{'<port>'} ?
     $conf->{-u}->{'<port>'} : "9000");
}

my $database = "freekbs2";
my $context = $conf->{'-c'} || "Org::FRDCSA::NLU::Test";
my $sayer1 = Sayer->new
  (
   DBName => "sayer_nlu",
  );
my $sayer2 = Sayer->new
  (
   DBName => "sayer_nlu_textanalysis",
  );
my $textanalysis = Capability::TextAnalysis->new
  (
   Sayer => $sayer2,
   Skip => {
	    "SemanticAnnotation" => 1,
	    "CycLsForNP" => 1,
	    "CoreferenceResolution" => 1,
	    "SpeechActClassification" => 1,
	   },
  );
my $client = KBS2::Client->new
  (
   Context => $context,
   Database => $database,
  );
my $resources = {};

# more rules

# if it is a word, and it starts with a capital letter
# possible capitalized acronym

# do named entity annotation, etc

my $patterns =
  {
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
					     if (! $resources->{Dictionary}) {
					       $resources->{Dictionary} = PerlLib::Dictionary->new
						 (
						  CaseSensitive => 0,
						 );
					     }
					     my $entry = ["has-dictionary-entry", ["dictionary-fn", "PerlLib::Dictionary", "English"], $args{Substring}];
					     if ($resources->{Dictionary}->Lookup(Word => $args{Substring})) {
					       Assert($entry);
					     } else {
					       Assert(["not",$entry]);
					     }
					   },
					  ],
			     },
  };

# implications

my $implications =
  [
   ["implies",
    ["and",
     ["matches-pattern", \*{'::?X'}, "Alpha-numeric String"],
     ["has-string", \*{'::?X'}, \*{'::?Y'}],
     ["has-dictionary-entry", ["dictionary-fn", "PerlLib::Dictionary", "English"], \*{'::?Y'}],
    ],
    ["derived-possibility", \*{'::?X'}, "English Word"],
   ],
  ];

if (exists $conf->{'--clear'}) {
  # clear the context
  $sayer1->ClearCache();
  $sayer2->ClearCache();
}

if (exists $conf->{'-r'}) {
  $client->ClearContext
    (
     Context => $context,
     Database => $database,
    );
  my $contents = read_file($conf->{'-f'});
  foreach my $implication (@$implications) {
    Assert($implication);
  }
  ProcessData
    (
     Data => [$contents],
    );
}
if (exists $conf->{'-t'}) {
  Tests();
}

sub ProcessData {
  my %args = @_;
  my $data = $args{Data};
  # get a data id from sayer for this, then begin asserting relationships
  # build an index for the data table
  my $ref = ref $data;
  if ($ref ne "ARRAY") {
    print "ERROR: must be an array reference\n";
  } else {
    # get a sayer reference for this data
    my $id = $sayer1->AddData(Data => $data);
    my $entryfn = ["entry-fn", "sayer", $id];
    my $count = scalar @$data;
    # first assert what type of item it is
    Assert(["has-entry-count",$entryfn,$count]);
    my $i = 0;
    foreach my $entry (@$data) {
      my $ref2 = ref $entry;
      if ($ref2 eq "") {
	Assert(["has-ref-type",["array-element", $entryfn, $i],"SCALAR"]);
	# go ahead and process scalar
	ProcessScalar
	  (
	   Scalar => $entry,
	   Index => $i,
	   EntryFn => $entryfn,
	  );
      } else {
	Assert(["has-ref-type",["array-element", $entryfn, $i],$ref2]);
      }
      ++$i;
    }
  }
}

# come up with a network of tests, for instance if something is 

sub ProcessScalar {
  my %args = @_;
  # here's what I am supposed to do with this, run those tests on
  # every substring, if we know that certain tests are going to fail,
  # avoid running them

  # for now iterate over every substring
  my $scalar = $args{Scalar};
  my $length = length($scalar);
  my $arrayelement = ["array-element", $args{EntryFn}, $args{Index}];
  Assert(["has-length",$arrayelement,$length]);

  if ($conf->{'--all'} or $conf->{'--pp'}) {
    # extract out visible surface patterns
    foreach my $pattern (keys %$patterns) {
      foreach my $regex (@{$patterns->{$pattern}->{Regex}}) {
	my @all = $scalar =~ /(.*?)($regex)(.*?)/g;
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
	  Assert(["has-string", ["substring-of",$arrayelement,$start,$end], $substr]);
	  Assert(["matches-pattern", ["substring-of",$arrayelement,$start,$end], $pattern]);
	  foreach my $trigger (@{$patterns->{$pattern}->{Triggers}}) {
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

  if ($conf->{'--all'} or $conf->{'--pw'}) {
    # perform textanalysis
    my $results = $textanalysis->ProcessText(Text => $scalar);
    # print Dumper($results);
    ProcessWSD
      (
       Results => $results,
       Scalar => $scalar,
       ArrayElement => $arrayelement,
      );
  }
}

sub Assert {
  my $ref = shift;
  if (0) {
    print Dumper($ref);
  } else {
    my $res = $client->Send
      (
       Assert => [$ref],
       InputType => "Interlingua",
       Database => $database,
       Context => $context,
       QueryAgent => 1,
       Flags => {
		 AssertWithoutCheckingConsistency => 1,
		},
      );
    return $res;
  }
}

sub Query {
  my $ref = shift;
  if (0) {
  } else {
    my $res = $client->Send
      (
       Query => [$ref],
       Type => "Models",
       InputType => "Interlingua",
       Database => $database,
       Context => $context,
       QueryAgent => 1,
      );
    return $res;
  }
}

sub Tests {
  # print Dumper(Query(["has-dictionary-entry", \*{'::?X'}, \*{'::?Y'}]));
  print Dumper(Query(["derived-possibility", \*{'::?X'}, "English Word"]));
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
  my %args = @_;
  my $WSD = $args{Results}->{WSD};
  my $text = $args{Scalar};

  my $length = length($text);
  my $chars = [split //, $text];
  my $pos = 0;
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
	      Assert(["word-sense-disambiguation", $item, "Pedersen", ["wordnet-sense", $wqd, $entry2->{POS}, $entry2->{Sense}]]);
	    }
	  } else {
	    ++$pos;
	  }
	}
      }
    }
  }
}

my $contexts =
  [
   "html_document",
   "xml_document",
   "ascii_text",
   "text",
   "sentence",
   "paragraph",
   "punctuation",
   "period",
   "whitespace_between_paragraphs",
   "title",
   "hex_characters",
   "date",
   "wikipedia_markup",
   "bullet_list",
   "timezone",
   "word",
   "phrase",
   "named_entity",
   "proper_noun",
   "noun",
   "verb",
   "adverb",
   "sentence_end_without_punctuation",
   "number",
   "wikipedia_markup_link",
   "wikipedia_markup_title",
   "wikipedia_markup_infobox",
   "lisp_notation_list",
   "lisp_notation_list_item",
   "lisp_notation_list_opening",
   "lisp_notation_list_closing",
   "pddl_domain",
   "pddl_domain_init_item",
   "FRDCSA_system_name",
   "perl_program",
   "perl_module",
   "perl_script",
   "html_tag",
   "url",
   "thing-at-point-symbol",
   "line",
   "line-end",
   "line-start",
   "fiction",
   "nonfiction",
   "article",
   "research_paper",
   "journal_paper",
   "book_chapter"
  ];

# how to incorporate context (easy, just include the theory around it,
# and use that to enforce rules, brilliant!)

# game theoretic search

my $tests = {
	     # given, the context

	    };


# develop a decision tree or some kind of machine learning system,
# where it learns which tests to apply - this is the learner
# component

# suppose this is true...

# what do we expect to be bear the highest amount of unknowns

# also what do we use to disambiguate to useful structures

sub PrintDomain {
  system "kbs2 --db ".shell_quote($database)." -c ".shell_quote($context)." show | sort";
}

if ($conf->{'--emacs'}) {
  my @tags;
  my $importexport = KBS2::ImportExport->new();
  my $message = $client->Send
    (
     QueryAgent => 1,
     Command => "all-asserted-knowledge",
     Context => $context,
    );
  # print Dumper($message);
  if (defined $message) {
    my $assertions = $message->{Data}->{Result};
    foreach my $assertion (@$assertions) {
      # go ahead and output span information
      # ("word-sense-disambiguation" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "17" "26") "Pedersen" ("wordnet-sense" "successor" "n" "2"))  
      # ("matches-pattern" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "97" "98") "Whitespace")
      # ?? ("has-string" ("substring-of" ("array-element" ("entry-fn" "sayer" "8") "0") "97" "98") "s")
      # get all the data

      if ($assertion->[0] =~ /^(word-sense-disambiguation|matches-pattern)$/) {
	my $converted = $importexport->Convert(Input => [$assertion], InputType => "Interlingua", OutputType => "Emacs String");
	push @tags, "'(".$assertion->[1]->[2]." ".$assertion->[1]->[3]." '".$converted->{Output}.")";
      }
    }
    my $result = "(setq nlu-tags (list ".join(" ", @tags)."))";
    print $result."\n";
    # (setq nlu-sample-spans
    #  (list
    #    '(1 10 '("matches-pattern" " "Space"))
    #    '(11 20 '("matches-pattern" "SELF" "Word"))
    #    '(21 30 '("word-sense-disambiguation" "SELF" "Pedersen" ("wordnet-sense" "time" "n" "5")))))
  }
}
