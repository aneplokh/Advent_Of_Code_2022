#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my %map = (
  X => "lose",
  Y => "draw",
  Z => "win",
  A => "Rock",
  B => "Paper",
  C => "Scissors"
);

my %win = (
  Rock => "Scissors",
  Paper => "Rock",
  Scissors => "Paper"
);

my %lose = (
  Rock => "Paper",
  Paper => "Scissors",
  Scissors => "Rock"
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
  
  my $shape;

  if($map{$self} eq "draw"){
    $shape = $map{$opp};
    $score +=3;
  }elsif($map{$self} eq "win"){
    $shape = $lose{$map{$opp}};
    $score += 6;
  }else{
    $shape = $win{$map{$opp}};
  }


  $score += $shape_score{$shape};

}

print "score: $score\n";
