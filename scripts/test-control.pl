#!/usr/bin/perl -w

use KBS2::Client;
use PerlLib::SwissArmyKnife;

use BOSS::Config;

use Data::Dumper;

$specification = q(
	-r		Run the processing
	--clear		Clear the context of the DB
	-t		Run the tests
	-p		Print the context
	-e		Execute the agent
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $database = "freekbs2";
my $context = "Org::FRDCSA::NLU::Test2";
my $client = KBS2::Client->new
  (
   Context => $context,
   Database => $database,
  );


my $poem = "Roses are red, violets are blue
I am schizophrenic, and so are you";

my $initialkb;
$initialkb =
  [
   ["isa", ["scalar-variable", "poem"], "poem"],
   ["not", ["test-applied","rhyming-function",["scalar-variable", "poem"]]],

   ["has-rhyming-scheme", ["poem-function", ["scalar-variable", "poem"]], "AB"],
   ["isa", ["substring-of", ["scalar-variable", "poem"], "0","31"], "stanza"],
   ["isa", ["substring-of", ["scalar-variable", "poem"], "31","65"], "stanza"],
   ["rhymes", "perfectly", ["stanza-function", ["substring-of", ["scalar-variable", "poem"], "0","31"]], ["stanza-function", ["substring-of", ["scalar-variable", "poem"], "31","65"]]],

   ["genls", "poem", "data"],
   ["implies", ["and", ["genls", \*{'::?A'}, \*{'::?B'}], ["genls", \*{'::?B'}, \*{'::?C'}]], ["genls", \*{'::?A'}, \*{'::?C'}]],
   ["implies", ["and", ["isa", \*{'::?A'}, \*{'::?B'}], ["isa", \*{'::?B'}, \*{'::?C'}]], ["isa", \*{'::?A'}, \*{'::?C'}]],
   ["implies", ["and", ["genls", \*{'::?A'}, \*{'::?B'}], ["isa", \*{'::?X'}, \*{'::?A'}]], ["isa", \*{'::?X'}, \*{'::?B'}]],
  ];


my $implications =
  [
   ["implies",
    ["and",
     ["isa", \*{'::?X'}, "poem"],
     ["not", ["test-applied","rhyming-function",\*{'::?X'}]],
    ],
    ["goal", ["test-applied","rhyming-function",\*{'::?X'}]],
   ],
  ];

my $actions =
  [
   ["action", "apply-test",
    ["preconditions",
     ["and",
      ["isa", \*{'::?X'}, "test"],
      ["isa", \*{'::?Y'}, "data"],
     ],
    ],
    ["effects",
     ["and",
      ["test-applied", \*{'::?X'}, \*{'::?Y'}],
     ]
    ],
   ],
  ];

if (exists $conf->{'--clear'}) {
  # clear the context
  $client->ClearContext
    (
     Context => $context,
     Database => $database,
    );
}

if (exists $conf->{'-r'}) {
  foreach my $fact (@$initialkb) {
    Assert($fact);
  }
  foreach my $implication (@$implications) {
    Assert($implication);
  }
}

if (exists $conf->{'-t'}) {
  # my $result = Query(["goal",\*{'::?X'}]);
  # print Dumper($result);

  my $result = Query(["isa",\*{'::?X'},"data"]);
  print Dumper($result);

  # my $result = Query(["goal", ["test-applied", "rhyming-function",["scalar-variable", \*{'::?X'}]]]);
  # foreach my $goal, how do you achieve this goal?  this will involve
  # using the planner to generate a sequence of actions that results
  # in the output state
}

if (exists $conf->{'-e'}) {
  # go ahead and generate the plan

  # take the goal, if it is already true, then it is complete, if not,
  # see if there are any actions which have the post condition that we
  # are looking for

  # goal ?X

  # effects ?X add preconditions to goal queue, and add to the plan space
  # the necessary action...

  # continue search until plan space exhausted
}

if (exists $conf->{'-p'}) {
  system "kbs2 --db ".shell_quote($database)." -c ".shell_quote($context)." show | sort";
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
