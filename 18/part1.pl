#!/usr/bin/perl
use strict;
use Data::Dumper;
open(FH, $ARGV[0]);
my %cubes;

while(<FH>){
  chomp;
  $cubes{$_}=1;
}

my $total_exposed_sides=0;

foreach my $c (sort keys %cubes){
  my ($x,$y,$z) = split /,/, $c;
  my $exposed_sides=6;
  my $xminus = $x-1;
  my $xplus = $x+1;
  my $yminus = $y-1;
  my $yplus = $y+1;
  my $zminus = $z-1;
  my $zplus = $z+1;

  if($cubes{"$xminus,$y,$z"} == 1){
    $exposed_sides--;
  }
  if($cubes{"$xplus,$y,$z"} == 1){
    $exposed_sides--;
  }
  if($cubes{"$x,$yminus,$z"} == 1){
    $exposed_sides--;
  }
  if($cubes{"$x,$yplus,$z"} == 1){
    $exposed_sides--;
  }
  if($cubes{"$x,$y,$zminus"} == 1){
    $exposed_sides--;
  }
  if($cubes{"$x,$y,$zplus"} == 1){
    $exposed_sides--;
  }

  $total_exposed_sides += $exposed_sides;
  print "at cube $c adding $exposed_sides\n";
}

print "$total_exposed_sides\n";
