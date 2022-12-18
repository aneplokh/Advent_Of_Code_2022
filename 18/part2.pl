#!/usr/bin/perl
use strict;
use Data::Dumper;
open(FH, $ARGV[0]);
my %cubes;

my $maxx=0;
my $minx=99999;
my $maxy=0;
my $miny=99999;
my $maxz=0;
my $minz=99999;

while(<FH>){
  chomp;
  my ($x,$y,$z) = split /,/, $_;
  $cubes{"$x,$y,$z"}=1;
  if($x > $maxx) {$maxx=$x};
  if($y > $maxy) {$maxy=$y};
  if($z > $maxz) {$maxz=$z};
  if($x < $minx) {$minx=$x};
  if($y < $miny) {$miny=$y};
  if($z < $minz) {$minz=$z};
  
}

print "x range: $minx to $maxx; y range: $miny to $maxy; z range: $minz to $maxz\n";

my %steam;
my @unknown;
for(my $x=$minx-1;$x<=$maxx+1;$x++){
  for(my $y=$miny-1;$y<=$maxy+1;$y++){
    for(my $z=$minz-1;$z<=$maxz+1;$z++){
      if($x == $minx || $x == $maxx || $y == $miny || $y == $maxy || $z == $minz || $z == $maxz){ #it's an edge
        if ($cubes{"$x,$y,$z"} != 1) {
          $steam{"$x,$y,$z"} = 1;
        }
      }elsif($cubes{"$x,$y,$z"} != 1){#it's not a cube and not known
        push(@unknown, "$x,$y,$z");
        #print "adding $x,$y,$z to unknown list\n";
      }
    }
  }
}

my $nsteam = keys %steam;
#print "initially $nsteam steam cubes\n";

my $found_steam=1;
while($found_steam == 1){
  my @unknown_after;
  $found_steam=0;
  foreach my $c (@unknown){
    #print "checking $c\n";
    my ($x,$y,$z) = split /,/, $c;
    my $xminus = $x-1;
    my $xplus = $x+1;
    my $yminus = $y-1;
    my $yplus = $y+1;
    my $zminus = $z-1;
    my $zplus = $z+1;
    if($steam{"$xminus,$y,$z"} == 1 || $steam{"$xplus,$y,$z"}==1 || $steam{"$x,$yminus,$z"}==1 || $steam{"$x,$yplus,$z"}==1 || $steam{"$x,$y,$zminus"}==1 || $steam{"$x,$y,$zplus"}==1){
      $steam{$c} = 1;
      $found_steam=1;
      #print "setting steam in $c\n";
    }else{
      push @unknown_after, $c;
      #print "still unknown $c\n";
    }
  }
 
  @unknown = @unknown_after;
  print "after this pass, $#unknown remain unknown\n";
  
}

my $total_exposed_sides=0;

foreach my $c (sort keys %cubes){
  my ($x,$y,$z) = split /,/, $c;
  my $exposed_sides=0;
  my $xminus = $x-1;
  my $xplus = $x+1;
  my $yminus = $y-1;
  my $yplus = $y+1;
  my $zminus = $z-1;
  my $zplus = $z+1;

  if($steam{"$xminus,$y,$z"} == 1){
    $exposed_sides++;
  }
  if($steam{"$xplus,$y,$z"} == 1){
    $exposed_sides++;
  }
  if($steam{"$x,$yminus,$z"} == 1){
    $exposed_sides++;
  }
  if($steam{"$x,$yplus,$z"} == 1){
    $exposed_sides++;
  }
  if($steam{"$x,$y,$zminus"} == 1){
    $exposed_sides++;
  }
  if($steam{"$x,$y,$zplus"} == 1){
    $exposed_sides++;
  }

  $total_exposed_sides += $exposed_sides;
  print "at cube $c adding $exposed_sides\n";
}

print "$total_exposed_sides\n";
