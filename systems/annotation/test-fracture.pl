#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

use Text::Fracture qw(init fract);

init({ max_lines => 20, max_cpl => 300, max_chars => 2000 });
my $text = read_file("sample-text.txt");
my $aref = fract($text);
# print Dumper($aref);

my @fragments;
foreach my $fragment (@$aref) {
  push @fragments, substr($text,$fragment->[0],$fragment->[1]);
}

print Dumper(\@fragments);
