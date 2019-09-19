#!/usr/bin/perl -w

use BOSS::Config;
use KBS2::Util;
use Lingua::EN::Sentence qw(get_sentences);
use PerlLib::SwissArmyKnife;

$specification = q(
	-c <constant>	Constant for text, eg "theFiveLoveLanguages_Book"
	<files>...	Files to be prepared
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $constantForBook =
  $conf->{'-c'} ||
  QueryUser('Constant for text, eg "theFiveLoveLanguages_Book"');

my @out;
my $space = " " x 17;
foreach my $file (@{$conf->{'<files>'}}) {
  if (-f $file) {
    my $contents = read_file($file);
    my $sentences = get_sentences($contents);
    my $i = 0;

    foreach my $sentence (@$sentences) {
      $sentence =~ s/\s+/ /sg;
      push @out, '%% '.$sentence."\n";
      push @out, 'sentence('.PrologQuote(Arg => $constantForBook),',sentenceIdFn('.++$i.'),'.PrologQuote(Arg => $sentence).").\n";
      push @out, 'hasFormalization('.PrologQuote(Arg => $constantForBook),',sentenceFn('.$i."),\n";
      push @out, $space."[\n";
      push @out, $space." _\n";
      push @out, $space."]).\n\n";
    }
    my $fh = IO::File->new;
    if ($fh->open('>'.$file.'.nlu.pl')) {
      print $fh ":- discontiguous sentence/3, hasFormalization/3.\n\n";
      print $fh join('',@out);
      $fh->close;
    }
  }
}
