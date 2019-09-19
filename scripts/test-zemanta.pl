#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

use Net::Zemanta::Suggest;

my $zemanta = Net::Zemanta::Suggest->new
  (
   APIKEY => 'rfxnhrv7srntxbusb99qte9h',
  );

my $suggestions = $zemanta->suggest
  (
   "Here we are with our Nineteenth Volume complete. We do not carry it to
Court to gain patronage, neither do we preface it with a costly dedication
to a purse-proud patron; but we present it at the levee of the people, as
a production in which the information and amusement of one and all are
equally kept in view. We know that instances have occurred of authors
tiring out their patrons. A pleasant story is told of Spencer, who sent
the manuscript of his Faery Queen to the Earl of Southampton, the Mecaenas
of those days; when the earl reading a few pages, ordered the poet to be
paid twenty pounds; reading further, another twenty pounds; and proceeding
still, twenty pounds more; till losing all patience, his lordship cried,
\"Go turn that fellow out of the house, for if I read on I shall be ruined.\"
We have no fear this will be our fate; especially as we strive to effect
all that can be accomplished in our economical form to follow as well as
direct the public taste.",
  );

print Dumper($suggestions);

# Suggested images
for $image (@{$suggestions->{images}}) {
  $image->{url_m};
  $image->{description};
}

# Related articles
for $article (@{$suggestions->{articles}}) {
  $article->{url};
  $article->{title};
}

# In-text links
for $link (@{$suggestions->{markup}->{links}}) {
  for $target (@{$link->{target}}) {
    $link->{anchor}, " -> ", $target->{url};
  }
}

# Keywords
for $keyword (@{$suggestions->{keywords}}) {
  $keyword->{name};
}
