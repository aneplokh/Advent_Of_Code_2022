#!/usr/bin/perl
use strict;

open (FH, $ARGV[0]);

my $redundant=0;

while(<FH>){
  chomp;
  my ($pair1,$pair2) = split /,/, $_;
 
  my ($pair1start,$pair1end) = split /-/, $pair1;
  my ($pair2start,$pair2end) = split /-/, $pair2;

  if ( ($pair1start >= $pair2start && $pair1end <= $pair2end) || ($pair2start >= $pair1start && $pair2end <= $pair1end)){
   $redundant++;
  }
}

print "redundant pairs: $redundant\n";
