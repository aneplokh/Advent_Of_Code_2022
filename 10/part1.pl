#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my $cycle = 1;
my $x = 1;

my $signal_strength=0;

while(<FH>){
  chomp;
  my $line = $_;
  if($line =~ m/noop/){
    $cycle++;
  }elsif($line =~ m/addx ([\-0-9]+)/){
    $cycle++;
    if($cycle == 20 || ($cycle-20) %40 == 0){
      $signal_strength += ($cycle * $x);
    }

    $cycle++;
    $x += $1;

  }

  if($cycle == 20 || ($cycle-20) %40 == 0){
    $signal_strength += ($cycle * $x);
  }

}

print "signal strength: $signal_strength\n";
