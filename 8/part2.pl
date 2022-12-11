#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my @matrix;

while(<FH>){
  chomp;
  my @line = split //, $_;
  push @matrix, \@line;
}

my $high_score=0;

for(my $x=0; $x<=$#matrix;$x++){
  for(my $y=0;$y<=$#{$matrix[$x]};$y++){
    my $height = $matrix[$x][$y];
    if($x==0 || $x == $#matrix || $y==0 || $y==$#{$matrix[$x]}){
     #ignore - scenic score is 0 
    }else{
      my $x1;
      my $y1;
      #look left 
      my $scenic_left=0;
      my $scenic_right=0;
      my $scenic_up=0;
      my $scenic_down=0;

      for($x1=$x-1; $x1 >= 0; $x1--){
        $scenic_left++;
        last if($matrix[$x1][$y] >= $height);
      }

      #look right
      for($x1=$x+1; $x1 <= $#matrix; $x1++){
        $scenic_right++;
        last if($matrix[$x1][$y] >= $height);
      }
 
      #look up 
      for($y1=$y-1; $y1 >= 0; $y1--){
        $scenic_up++;
        last if($matrix[$x][$y1] >= $height);
      }
      
      #look down 
      for($y1=$y+1; $y1 <= $#{$matrix[$x]}; $y1++){
        $scenic_down++;
        last if($matrix[$x][$y1] >= $height);
      }

      my $score = $scenic_left * $scenic_right * $scenic_up * $scenic_down;
      if($score > $high_score) {
        $high_score = $score;
      }
    
    }
  }
}


print "$high_score\n";

