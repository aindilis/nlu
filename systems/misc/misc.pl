#!/usr/bin/perl -w

use Capability::CoreferenceResolution;
use PerlLib::SwissArmyKnife;

my $text = read_file("sample-annotation.txt");

my $coref = Capability::CoreferenceResolution->new;
$coref->StartServer;
print Dumper
  (
   $coref->ReplaceCoreferences
   (Text => $text)
  );
