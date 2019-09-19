#!/usr/bin/perl -w

use PPI::Document;
use PPI::Dumper;

my $module = PPI::Document->new("test.pl");
my $dumper = PPI::Dumper->new( $module );
$dumper->print;
