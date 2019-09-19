#!/usr/bin/perl -w

use BOSS::Config;
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
      push @out, ';; '.$sentence."\n";
      push @out, '(#$nluManuallyFormalizedText'."\n";
      push @out, ' (#$sentenceFn "'.shell_quote($sentence).'")'."\n";
      push @out, ' \'())'."\n\n";
    }
    my $fh = IO::File->new;
    if ($fh->open('>'.$file.'.nlu.subl')) {
      print $fh '(pred-3 "nluManuallyFormalizedText" #$Text #$Sentence #$NLUManualFormalizationMt)'."\n";
      print $fh '(pred-3 "hasTranslation" #$Text #$Language #$Text #$NLUManualFormalizationMt)'."\n\n";
      print $fh join('',@out);
      $fh->close;
    }
  }
}

# sub prolog_quote {
#   my (%args) = @_;
#   my $text = $args{Text};
#   my $quoted = shell_quote($text);
#   $quoted =~ s/^'?/'/s;
#   $quoted =~ s/'?$/'/s;
#   return $quoted;
# }
