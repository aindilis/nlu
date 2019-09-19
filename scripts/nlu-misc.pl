#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

$specification = q(
	-f <file>	File to process
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

# my $file = $conf->{'-f'};
my $file = '/var/lib/myfrdcsa/codebases/minor/nlu/unstructured-data-corpus/W41.txt';

my $c = read_file($file);

# use KBFS here

my $kbfsassertions =
  [
   [
    'has-type',
    ['FileClassID', 1],
    'research paper'
   ],
  ];

# if the file is a research paper, then it probably has an author or
# authors and a title


