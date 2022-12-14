#!/usr/bin/perl
use strict;
use Data::Dumper;

open(FH, $ARGV[0]);

my %map;
my $maxy=0;

while(<FH>){
  #498,4 -> 498,6 -> 496,6
  chomp;
  my @vertices = split / \-\> /, $_;
  for(my $i = 0; $i<$#vertices; $i++){
    my ($v1x,$v1y) = split /,/, $vertices[$i]; 
    my ($v2x,$v2y) = split /,/, $vertices[$i+1];
    if($v1y>$maxy){$maxy=$v1y;}
    if($v2y>$maxy){$maxy=$v2y;}

    if($v1x==$v2x){
      if($v1y<$v2y){
        for (my $y = $v1y; $y <= $v2y; $y++){
          $map{"$v1x,$y"}=1;
        }
      }else{
        for (my $y = $v2y; $y <= $v1y; $y++){
          $map{"$v1x,$y"}=1;
        }
      }
    }elsif($v1y==$v2y){
      if($v1x<$v2x){
        for (my $x = $v1x; $x <= $v2x; $x++){
          $map{"$x,$v1y"}=1;
        }
      }else{
        for (my $x = $v2x; $x<= $v1x; $x++){
          $map{"$x,$v1y"}=1;
        }
      }
    }else{
      die "invalid path\n";
    }
    
  }
}

my $overflow=0;
my $grains = 0;

while(!$overflow){
  $grains++;
  my $x=500;
  my $y=0;
  my $moving = 1;

  while($moving==1 && $y < $maxy){
    print "moving grain $grains, from $x,$y; max y = $maxy\n";
    my $nexty = $y+1;
    if($map{"$x,$nexty"} != 1){ #first try straight down
      $y++;
    #  print "grain $grains moving straight down\n";
    }else{
      my $nextx=$x-1;
      if($map{"$nextx,$nexty"} != 1){ #try down-left
        $x--;$y++;
    #    print "grain $grains moving down-left ($nextx,$nexty)\n";
      }else{
        $nextx=$x+1;
        if($map{"$nextx,$nexty"}!=1){ #try down-right
          $x++;$y++;
    #      print "grain $grains moving down-rightt ($nextx,$nexty)\n";
        }else{ #it's stuck here
          $moving=0;
          $map{"$x,$y"} = 1;
    #      print "grain stopped at $x,$y\n";
        }
      }
    }
  }
  if($y>=$maxy){$overflow=1};
}

$grains--;

print "$grains grains dropped\n";
