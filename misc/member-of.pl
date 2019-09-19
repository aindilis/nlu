# ("member-of" "Jane" "FemaleFirstNames")
# have code invocations

my $sets =
  {
   "FemaleFirstNames" => {
			  "Jane" => 1,
			  "Julie" => 1,
			 },
  };

sub MemberOf {
  my %args = @_;
  if (exists $sets->{$args{Set}}) {
    if (exists $sets->{$args{Set}}->{$args{Element}}) {
      return {
	      Success => 1,
	      Result => 1,
	     };
    } else {
      return {
	      Success => 1,
	      Result => 0,
	     };
    }
  } else {
    return {
	    Success => 0,
	   };
  }
}


sub Query {
  my $query = shift;
  if ($query->[0] eq "member-of") {
    if (MemberOf
	(
	 Element => $query->[1],
	 Set => $query->[2],
	)) {

    }
  }
}
