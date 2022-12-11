#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my %map = (
  X => "Rock",
  Y => "Paper",
  Z => "Scissors",
  A => "Rock",
  B => "Paper",
  C => "Scissors"
);

my %win = (
  Rock => "Scissors",
  Paper => "Rock",
  Scissors => "Paper"
);

my %shape_score = (
  Rock => 1,
  Paper => 2,
  Scissors => 3
);

my $score=0;

while(<FH>){
  chomp;
  my ($opp,$self) = split /\s+/, $_; 

  if($map{$self} eq $map{$opp}){
    #draw
   $score +=3;
  }elsif($win{$map{$self}} eq $map{$opp}){
   $score +=6;
  }

  $score += $shape_score{$map{$self}};
  print "after $opp, $self score is $score\n";

}

print "score: $score\n";
