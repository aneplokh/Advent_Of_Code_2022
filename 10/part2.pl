#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my $cycle = 0;
my $x = 1;

while(<FH>){
  chomp;
  my $line = $_;

  my $hpos = $cycle % 40;

  if (abs($x-$hpos) <= 1){
    print "#";
  }else{
    print ".";
  }
  if ($hpos == 39){
    print "\n";
  }


  if($line =~ m/noop/){
    $cycle++;
  }elsif($line =~ m/addx ([\-0-9]+)/){
    $cycle++;
    $hpos = $cycle % 40;

    if (abs($x-$hpos) <= 1){
      print "#";
    }else{
      print ".";
    }
    if ($hpos == 39){
      print "\n";
    }

    $cycle++;
    $x += $1;

  }

}


