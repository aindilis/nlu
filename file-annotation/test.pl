#!/usr/bin/perl -w

# go through each file and directory

# prove things that are true about it

foreach my $filename (split /\n/, `ls ~/`) {
  print "<$filename>\n";
  GenerateAssertions
    (
     Data => $filename,
     Assertions => [
		    ["FilenameP", ["filename-fn", $filename]],
		   ],
    );
}

# have type prerequisites on tests
# have expected timing on tests, worst-case, etc
# have composite tests

# have multiple answer types

my $tests =
  {
   "FileTests" => {
		   IsFileP => {
			       Sub => sub { -f $_[0] },
			       Type => "boolean",
			      },
		   IsDirP => sub { -d $_[0] },
		   ExistsP => sub { -x $_[0] },
		  },
  };

my $knowledge = [
		 "(implies (or (IsFileP ?X) (IsDirP ?X)) (ExistsP ?X))",
		 "(implies (FilenameP ?X) (and (propose-test IsDirP ?X) (propose-test DirTest ?X)))",
		 "(implies (IsDirP ?X) (queue-test DirTest ?X))",
		];

# propose tests

sub GenerateAssertions {
  my %args = @_;
  # 





  my @assertions;
  # run tests

  foreach my $testsuite (keys %$tests) {
    foreach my $test (keys %{$tests->{$testsuite}}) {
      my $sub = $tests->{$testsuite}->{$test};

      # if the test is a binary test, use those results
      $sub->($args{Item})
    }
  }
}

