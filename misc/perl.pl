#!/usr/bin/perl -w

use KBS2::ImportExport;
use PerlLib::SwissArmyKnife;

use PPI::Document;
use PPI::Dumper;




my $text = read_file("wsd.pl");

# run PPI and dump the results

my $filename = "/tmp/nlu-perl.pl";
system "rm ".shell_quote($filename);
my $fh = IO::File->new;
$fh->open(">$filename") or die "Cannot open $filename\n";
print $fh $text;
$fh->close();

my $module = PPI::Document->new($filename);
# my $dumper = PPI::Dumper->new( $module );
# $dumper->print;

# print Dumper($module);

my $res = ExtractPropositions
  (
   Node => $module,
   Start => 0,
  );
my @formulae = @{$res->{Formulae}};
my $ie = KBS2::ImportExport->new;
my $res = $ie->Convert
  (
   Input => \@formulae,
   InputType => "Interlingua",
   OutputType => "Emacs String",
  );
if ($res->{Success}) {
  print $res->{Output}."\n";
}

sub NodeSerialize {
  my (%args) = @_;
  my $doc = PPI::Document->new();
  $doc->add_element(GetCopy(Node => $args{Node}));
  return $doc->serialize;
}

sub GetCopy {
  my (%args) = @_;
  my $VAR1 = undef;
  eval Dumper($args{Node});
  return $VAR1;
}

sub ExtractPropositions {
  my %args = @_;
  my @formulae;
  my $node = $args{Node};
  my $start = $args{Start};
  my $current = $start;
  my $ref = ref $node;
  my $serialized = NodeSerialize(Node => $node);
  my $length = GetLength($serialized);
  my @childrenentryrelations;
  if ($node->isa('PPI::Token')) {
    $current += $length;
  } elsif ($node->isa("PPI::Node")) {
    my @children = $node->children;
    foreach my $child (@children) {
      my $res = ExtractPropositions
	(
	 Node => $child,
	 Start => $current,
	);
      $current = $res->{Current};
      push @formulae, @{$res->{Formulae}};
      push @childrenentryrelations, $res->{EntryRelation};
    }
  }
  my $end = $current;
  my $entryrelation = ["substring-of", ["array-element", ["entry-fn", "sayer", "8"], "0"], $start, $end];
  push @formulae, ["has-tag-type", $entryrelation, $ref];
  push @formulae, ["has-string", $entryrelation, $serialized];
  foreach my $childentryrelation (@childrenentryrelations) {
    push @formulae, ["has-containing-tag", $childentryrelation, $entryrelation];
  }
  return {
	  Current => $current,
	  Formulae => \@formulae,
	  EntryRelation => $entryrelation,
	 };
}

sub GetLength {
  my $item = shift;
  return length($item);
  my $string = join(".",split /\n/, $item);
  return length($string);
}
