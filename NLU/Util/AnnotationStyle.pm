package NLU::Util::AnnotationStyle;

use PerlLib::SwissArmyKnife;

require Exporter;
@ISA = qw(Exporter);

@EXPORT = qw (InlineToStandoff StandoffToInline PrintSpans);

sub Test {
  my $c = read_file("sample-job.tagged");
  my $res = InlineToStandoff(Contents => $c);
  # print Dumper($res);
  if ($res->{Success}) {
    PrintSpans(
	       Text => $res->{Text},
	       Spans => $res->{Spans},
	      );
    print Dumper
      (StandoffToInline
       (
	Text => $res->{Text},
	Spans => $res->{Spans},
       ));
  }
}

sub InlineToStandoff {
  my %args = @_;
  my $debug = 0;
  if (defined $args{Debug}) {
    $debug = $args{Debug};
  }
  my $c = $args{Contents};
  $c = "<doc>$c</doc>";
  my @chars = split //, $c;
  my $i = 0;
  my $abspos = 0;
  my @text;
  my @tag;
  my @spans;
  my @tagstack;
  my $state = "init";
  foreach my $char (@chars) {
    print "$char $state\n" if $debug > 10;
    if ($char eq "<") {
      # potential start tag
      if ($state eq "inside-tag") {
	# mark the position as the beginning of the potential tag
	$tagstartpos = $i;
	@tag = ();
      } else {
	$state = "inside-tag";
	$tagstartpos = $i;
	@tag = ();
      }
    } elsif ($char eq ">") {
      if ($state eq "inside-tag") {
	$tagendpos = $i;
	my $inside = join("",@tag);
	if ($inside =~ /^\w+$/) {
	  # could be a starting tag
	  my $tag = {
		     Tag => $inside,
		     TagStartPos => $tagstartpos,
		     TagEndPos => $tagendpos,
		     AbsPos => $abspos,
		     Text => [],
		    };
	  my $size = scalar @tagstack;
	  push @tagstack, $tag;
	  my $indent =  " " x $size;
	  print "${indent}span-start: ".$tag->{Tag}."\n" if $debug > 4;
	  print Dumper(\@tagstack) if $debug > 7;
	  $state = "outside-tag";
	} elsif ($inside =~ /^\/\w+$/) {
	  my $tag = {
		     Tag => $inside,
		     TagStartPos => $tagstartpos,
		     TagEndPos => $tagendpos,
		     AbsPos => $abspos,
		    };
	  my $last = pop @tagstack;
	  if ("/".$last->{Tag} eq $tag->{Tag}) {
	    # the stack matches, add a tag span here

	    # "sample <tagged><text>is</text></tagged>"
	    # text -> "sample is"
	    # tags -> (tagged 8 10), (text 8 10)
	    my $size = scalar @tagstack;
	    my $indent =  " " x $size;
	    print $indent." <".join("",map {$_->[0]} @{$last->{Text}}).">\n" if $debug > 4;
	    print "${indent}span-end: ".$last->{Tag}."\n" if $debug > 4;
	    print Dumper(\@tagstack) if $debug > 7;
	    push @spans, [
			  $last->{Tag},
			  $last->{AbsPos},
			  $tag->{AbsPos},
			 ];
	    $state = "outside-tag";
	  } else {
	    print"parse error\n";
	    print Dumper([$last,$tag,\@tagstack]);
	    die;
	  }
	}
	my $tag = "<".join("",@tag).">";
	if ($tag =~ /^<\//) {

	}
      } elsif ($state eq "outside-tag") {
	push @{$tagstack[$#tagstack]->{Text}}, [$char,$i];
	push @text, $char;
	++$abspos;
      }
    } else {
      if ($state eq "inside-tag") {
	# push the character onto the tag info
	push @tag, $char;
      } else {
	push @{$tagstack[$#tagstack]->{Text}}, [$char,$i];
	push @text, $char;
	++$abspos;
      }
    }
    ++$i;
  }
  return {
	  Success => 1,
	  Spans => \@spans,
	  Text => join("",@text),
	 };
}

sub PrintSpans {
  my %args = @_;
  my @text = split //, $args{Text};
  foreach my $span (@{$args{Spans}}) {
    print Dumper($span);
    my @spantext;
    foreach my $k ($span->[1]..($span->[2]-1)) {
      push @spantext, $text[$k];
    }
    print join("",@spantext)."\n";
  }
}

sub StandoffToInline {
  my %args = @_;
  # KNOWN ERRORS (doesn't handle tags precedence, i.e. knowing which
  # tags enclose which, when the tags have the same span length and
  # position)

  # take the spans and the text and generate the "XML"
  my @all;
  my @tags;
  foreach my $span (@{$args{Spans}}) {
    my $starttag = {
		    Tag => "<".$span->[0].">",
		    Type => "Start",
		    Length => $span->[2] - $span->[1],
		   };
    my $endtag = {
		  Tag => "</".$span->[0].">",
		  Type => "End",
		  Length => $span->[2] - $span->[1],
		 };
    if (! defined $tags[$span->[1]]) {
      $tags[$span->[1]] = [];
    }
    push @{$tags[$span->[1]]}, $starttag;
    if (! defined $tags[$span->[2]]) {
      $tags[$span->[2]] = [];
    }
    push @{$tags[$span->[2]]}, $endtag;
  }
  my $i = 0;
  foreach my $char (split //, $args{Text}) {
    if (defined $tags[$i]) {
      # now work out the tag order
      # rules are, end tags first
      # end tags are sorted by shortest first
      # start tags are sorted by longest first
      my @start;
      my @end;
      my @order;
      foreach my $tag (@{$tags[$i]}) {
	if ($tag->{Type} eq "Start") {
	  push @start, $tag;
	} else {
	  push @end, $tag;
	}
      }
      # now for the end tags
      # sort them
      push @order, map {$_->{Tag}} sort {$a->{Length} <=> $b->{Length}} @end;
      # now for start tags
      push @order, map {$_->{Tag}} sort {$b->{Length} <=> $a->{Length}} @start;
      push @all, join("",@order);
    }
    push @all, $char;
    ++$i;
  }
  if (defined $tags[$i]) {
    push @all, join("",map {$_->{Tag}} @{$tags[$i]});
  }
  return {
	  Success => 1,
	  Result => join("",@all),
	 };
}

1;
