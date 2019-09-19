#!/usr/bin/perl -w

use System::Liferea;

# copy the liferea cachedir to someplace more local

my $feedcachedir = "/var/lib/myfrdcsa/codebases/minor/nlu/data/liferea-feeds";
system "mkdir -p $feedcachedir && cp -ar ~/.liferea/cache/feeds/* $feedcachedir";

my $liferea = System::Liferea->new
  (
   FeedCacheDir => $feedcachedir,
  );
# $liferea->LoadFeeds(BuildCorpus => 1);
