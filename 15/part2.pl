#!/usr/bin/perl
use strict;
use Data::Dumper;
use List::Util qw(min max);

open(FH, $ARGV[0]);
my $max_coord = $ARGV[1];

my %sensor;
my %sensor_dist;

while(<FH>){
  # Sensor at x=2, y=18: closest beacon is at x=-2, y=15
  if ($_ =~ m/Sensor at x=([\-\d]+), y=([\-\d]+): closest beacon is at x=([\-\d]+), y=([\-\d]+)/){
   $sensor{"$1,$2"} = "$3,$4";
   $sensor_dist{"$1,$2"} = manhattan_dist($1,$2,$3,$4);
  }else{
    die "bad input";
  }
}

for(my $row=0;$row<=$max_coord;$row++){
  my @ranges;
  foreach my $s (keys %sensor){
    my ($sx,$sy) = split /,/, $s;
    my $vert = abs($sy - $row);
    if($sensor_dist{$s} >= $vert){
      my $left = max (0, $sx-($sensor_dist{$s}-$vert)); 
      my $right = min ($max_coord,$sx+($sensor_dist{$s}-$vert));
      push @ranges, ([$left,$right]);
    }
  }

  my $leftmost=$max_coord;
  my $rightmost=0;
  foreach my $range (sort {@$a[0] <=> @$b[0]} @ranges){
    my ($l,$r) = @$range;
    if($l <= $leftmost){$leftmost = $l};
    if($l <= ($rightmost+1) && $r > $rightmost){
      $rightmost=$r;
    }elsif($l > ($rightmost+1)){
      print "found possible beacon between $rightmost and $l $row\n";
      my $freq = ($l-1)*4000000 + $row;
      print "frequency is $freq\n" ;
      exit;
    }
  }

}

sub manhattan_dist{
  my ($x1,$y1,$x2,$y2) = @_;

  return((abs($x1-$x2)+abs($y1-$y2)));
}
