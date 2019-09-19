#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $sentence = "This is a test sentence.";
my $patterns =
  {
   "Whitespace" => [qr/\b\s+\b/],
   "Space" => [qr/\b\s\b/],
   "Closing period" => [qr/\b\.\s?/],
   "Alpha-numeric String" => [qr/\b\w+\b/],
  };

foreach my $pattern (keys %$patterns) {
  foreach my $regex (@{$patterns->{$pattern}}) {
    my @all = $sentence =~ /(.*?)($regex)(.*?)/g;
    my $total = 0;
    while (@all) {
      my ($a,$b,$c) = (shift @all, shift @all, shift @all);
      $total += length($a);
      $start = $total;
      $total += length($b);
      $end = $total;
      $total += length($c);
      my $substr = substr($sentence,$start,$end-$start);
      print Dumper([$start,$end,$substr,$pattern])."\n";
    }
  }
}
