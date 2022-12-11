#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my @matrix;

while(<FH>){
  chomp;
  my @line = split //, $_;
  push @matrix, \@line;
}

my $visible=0;

for(my $x=0; $x<=$#matrix;$x++){
  for(my $y=0;$y<=$#{$matrix[$x]};$y++){
    my $height = $matrix[$x][$y];
    if($x==0 || $x == $#matrix || $y==0 || $y==$#{$matrix[$x]}){
      $visible++;
    }else{
      my $highest=0;
      my $x1;
      my $y1;
      #look left 
      for($x1=0; $x1 < $x; $x1++){
        if($matrix[$x1][$y] > $highest){
          $highest = $matrix[$x1][$y];
        }
      }

     if($highest < $height){
      $visible++;
     } else {
      $highest=0; 
      #look right
      for($x1=$x+1; $x1 <= $#matrix; $x1++){
        if($matrix[$x1][$y] > $highest){
          $highest = $matrix[$x1][$y];
        }
      }
      if($highest < $height){
       $visible++;
      }else {
        $highest=0; 
      #look up
        for($y1=0; $y1 < $y; $y1++){
          if($matrix[$x][$y1] > $highest){
            $highest = $matrix[$x][$y1];
          }
        }
        if($highest < $height){
          $visible++;
        }else { 
          $highest=0; 
          #lookdown 
          for($y1=$y+1; $y1 <= $#{$matrix[$y]}; $y1++){
            if($matrix[$x][$y1] > $highest){
              $highest = $matrix[$x][$y1];
            }
          }
          if($highest < $height){
            $visible++;
          }
        }
      }
     }
    
    }
  }
}


print "$visible\n";

