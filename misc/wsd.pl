#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $c = read_file("wsd.dat");
eval $c;

my $text = read_file("texts/data.txt");
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
	    print Dumper([$start,$end,$word]);
	  }
	} else {
	  ++$pos;
	}
      }
    }
  }
}
