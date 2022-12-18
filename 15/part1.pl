#!/usr/bin/perl
use strict;
use Data::Dumper;

open(FH, $ARGV[0]);
my $test_y = $ARGV[1];

my %sensor;

while(<FH>){
  # Sensor at x=2, y=18: closest beacon is at x=-2, y=15
  if ($_ =~ m/Sensor at x=([\-\d]+), y=([\-\d]+): closest beacon is at x=([\-\d]+), y=([\-\d]+)/){
   $sensor{"$1,$2"} = "$3,$4";
  }else{
    die "bad input";
  }
}

my %nobeacon;

foreach my $s (keys %sensor){
  my ($sx,$sy) = split /,/, $s;
  my ($bx,$by) = split /,/, $sensor{$s};

  my $dist = manhattan_dist($sx,$sy,$bx,$by);
  #print "marking non-beacons $dist distance from $sx,$sy (closer than $bx,$by)\n";
  my $vert = abs($sy - $test_y);
  if($vert <= $dist){
    my $left = $sx-($dist-$vert);
    my $right = $sx+($dist-$vert);
    for(my $x=$left;$x<=$right;$x++){
      if(manhattan_dist($sx,$sy,$x,$test_y) <= $dist && ($bx !=$x || $by != $test_y)) {
        $nobeacon{$x}=1;
      }elsif($bx == $x && $by==$test_y){
        #print "came across beacon at $x,$test_y\n";
      }
    }
  }else{
    #print "too far from row $test_y to check\n";
  }
}


my $num_nobeacon = keys %nobeacon;
print "$num_nobeacon places without beacons\n";

sub manhattan_dist{
  my ($x1,$y1,$x2,$y2) = @_;

  return((abs($x1-$x2)+abs($y1-$y2)));
}
