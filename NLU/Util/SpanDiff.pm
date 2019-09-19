package NLU::Util::SpanDiff;

use NLU::Util::AnnotationStyle;
use PerlLib::SwissArmyKnife;

use Algorithm::Diff qw(diff);

require Exporter;
@ISA = qw(Exporter);

@EXPORT = qw (ComputeDiffOnSpans);

# see File: elisp,  Node: Sticky Properties,  Next: Saving Properties,  Prev: Format Properties,  Up: Text Properties

# note can use the text character 7 to point to the right side of the
# above character in some equispaced fonts

# have ascii art understanding system eventually, part of a diagram understanding system

# "tagged 's text"
# "tagged's text" ->
# spans would go from 0,7 to 0,7, 8,10, 7,9, and 11,15 to 10,14

sub Test {
  my $spans = [
	       ["tag1",0,3],
	       ["tag2",5,7],
	      ];
  my @a = qw(a b c e h j l m n p);
  my @b = qw(b c d e f j k l m r s t);

#    [ [ '-', 8, 'n' ], 
#      [ '-', 9, 'p' ], 
#      [ '+', 9, 'r' ], 
#      [ '+', 10, 's' ], 
#      [ '+', 11, 't' ],
#    ]

# the rule is foreach change, if change is negative

#    [ [ '-', 8, 'n' ], 
#      [ '-', 8, 'p' ], 
#      [ '+', 8, 'r' ], 
#      [ '+', 9, 's' ], 
#      [ '+', 10, 't' ],
#    ]

  PrintSpans
    (
     Text => join("", @a),
     Spans => $spans,
    );

  # <tag1>abc</tag1>ehjlmnp
  #    <tag2>bc</tag2>defjklmrst
  # or <tag2>bcd</tag2>efjklmrst

  # now compute the diff

  my $res = ComputeDiffOnSpans
    (
     StartingText => join("",@a),
     EndingText => join("",@b),
     Spans => $spans,
    );

  if ($res->{Success}) {
    PrintSpans
      (
       Text => join("",@b),
       Spans => $res->{Spans},
      );
  }
}

sub ComputeDiffOnSpansOld {
  my %args = @_;
  my @a = split //, $args{StartingText};
  my @b = split //, $args{EndingText};
  my $diff = [diff(\@a,\@b)];
  foreach my $changesequence (@$diff) {
    foreach my $change (@$changesequence) {
      my $loc = $change->[1] + 0;
      if ($change->[0] eq "+") {
	# it's adding, now increment all the spans greater than the current location
	foreach my $span (@{$args{Spans}}) {
	  if ($span->[1] > $loc) {
	    ++$span->[1];	# increment it
	    ++$span->[2];
	  } elsif ($span->[1] == $loc) {
	    # depending on sticky
	    # increment it for now or not?

	    if ($span->[2] > $loc) {
	      ++$span->[2];
	    } else {
	      # it must be equal
	      # depending on sticky
	      # increment it for now or not?
	    }
	  } elsif ($span->[1] < $loc) {
	    # try span 2, just in case
	    if ($span->[2] > $loc) {
	      ++$span->[2];	# increment it
	    } elsif ($span->[2] == $loc) {
	      # depending on sticky
	      # increment it for now or not?

	    } elsif ($span->[2] < $loc) {
	      # they're both less, ignore
	    }
	  }
	}
      } elsif ($change->[0] eq "-") {
	# it's adding, now increment all the spans greater than the current location
	foreach my $span (@{$args{Spans}}) {
	  if ($span->[1] >= $loc) {
	    # they must both be greater than or equal, in which case both are decremented
	    if ($span->[1] > 0) {
	      --$span->[1];	# decrement it
	    }
	    if ($span->[2] > 0) {
	      --$span->[2];
	    }
	  } elsif ($span->[1] < $loc) {
	    # nothing happens for 1, check 2
	    # try span 2, just in case
	    if ($span->[2] >= $loc) {
	      --$span->[2];	# decrement it
	    }
	  }
	}
      }
    }
  }
  return {
	  Success => 1,
	  Spans => $args{Spans},
	 };
  # take the first list
}

sub ComputeDiffOnSpans {
  my %args = @_;
  my $debug = 0;
  my $tmp = StandoffToInline
    (
     Text => $args{StartingText},
     Spans => $args{StartingSpans},
    );
  die unless $tmp->{Success};
  my $a = $tmp->{Result};
  my $b = $args{EndingText};
  # print Dumper({AAAA => $a});
  my $ares = InlineToStandoff(Contents => $a);
  # print Dumper({ARES => $ares});
  my @list = map {[[$_,{}]]} split //, $ares->{Text};
  my $i = 0;
  my $spans = {};
  foreach my $span (@{$ares->{Spans}}) {
    next if $span->[0] eq "doc";
    $spans->{$i} = $span->[0];
    print Dumper({Span => $span}) if $debug > 5;
    for (my $j = $span->[1]; $j < $span->[2]; ++$j) {
      $list[$j]->[0]->[1]->{$i} = 1;
    }
    ++$i;
  }

  # now compute the diff and then execute it
  my $sequences = diff([split //, $ares->{Text}],[split //, $b]);
  print Dumper($sequences) if $debug > 5;
  foreach my $sequence (@$sequences) {
    foreach my $change (@$sequence) {
      my $op = $change->[0];
      my $pos = $change->[1];
      if ($op eq "-") {
	# delete the item
	shift @{$list[$pos]};
      } elsif ($op eq "+") {
	# if there is already an item here
	push @{$list[$pos]}, [$change->[2],{}];
      }
    }
  }

  # now reassemble
  my @answer;
  my @spans;
  $i = 0;
  my $currentspans = {};
  foreach my $elt (@list) {
    foreach my $item (@$elt) {
      push @answer, $item->[0];
      foreach my $id (keys %$currentspans) {
	if (! exists $item->[1]->{$id}) {
	  # close the tag
	  $currentspans->{$id}->[2] = $i;
	  push @spans, $currentspans->{$id};
	  delete $currentspans->{$id};
	}
      }
      foreach my $id (keys %{$item->[1]}) {
	if (! exists $currentspans->{$id}) {
	  $currentspans->{$id} = [$spans->{$id},$i,undef];
	}
      }
      ++$i;
    }
  }
  my $text = join("", @answer);
  return {
	  Success => 1,
	  EndingSpans => \@spans,
	  EndingText => $text,
	 };
}

1;
