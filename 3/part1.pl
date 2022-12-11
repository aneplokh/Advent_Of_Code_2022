#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my $total_priority=0;

while(<FH>){
  chomp;
  my @line = split //, $_;
  my $numitems = $#line+1;

  my %seen = ();
  my $i;
  my $char;
  my $priority;
  for ($i=0; $i < $numitems/2; $i++){
    $seen{$line[$i]} = 1;
  }

  for ($i;$i<$numitems;$i++){
    if($seen{$line[$i]} == 1){
      $char = $line[$i];
    }
  }

  if(ord($char) > 96){
    $priority = ord($char) - 96;
  } else {
    $priority = ord($char) - 38;
  }
  $total_priority += $priority;
}

print "total priority: $total_priority\n";
