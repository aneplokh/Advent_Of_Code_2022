#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my $total_priority=0;

while(<FH>){
  chomp;

  my @line = split //, $_;
  my %seen = ();
  my $badge;
  my $item;
  foreach $item (@line){
    $seen{$item} = 1;
  }
  
  my @line = split //, <FH>;
  foreach $item (@line){
    if($seen{$item} == 1){
      $seen{$item} = 2;
    }
  }
  
  my @line = split //, <FH>;
  foreach $item (@line){
    if($seen{$item} == 2){
      $badge = $item;
    }
  }
  
  my $priority;

  if(ord($badge) > 96){
    $priority = ord($badge) - 96;
  } else {
    $priority = ord($badge) - 38;
  }
  $total_priority += $priority;
}

print "total priority: $total_priority\n";
