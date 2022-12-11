#!/usr/bin/perl
use Data::Dumper;
use strict;

open (FH, $ARGV[0]);

my %TPOS;

$TPOS{"0,0"}=1;

my @xpos=(0,0,0,0,0,0,0,0,0,0);
my @ypos=(0,0,0,0,0,0,0,0,0,0);

while(<FH>){
  chomp;
  my ($dir,$num) = split /\s+/, $_;

  for(my $i=1;$i<=$num;$i++){
    if($dir eq "R"){
      $xpos[0]++;
    }elsif($dir eq "L"){
      $xpos[0]--;
    }elsif($dir eq "U"){
      $ypos[0]++;
    }elsif($dir eq "D"){
      $ypos[0]--;
    }

    for(my $j=1;$j<10;$j++){
      if(abs($xpos[$j] - $xpos[$j-1]) > 1){ #need to adjust horizontal
        if($xpos[$j] > $xpos[$j-1]){
          $xpos[$j]--;
        }else{
          $xpos[$j]++;
        }
        if($ypos[$j] != $ypos[$j-1]){ # also vertical 
          if($ypos[$j] > $ypos[$j-1]){
            $ypos[$j]--;
          }else{
            $ypos[$j]++;
          }
        }
      }elsif(abs($ypos[$j] - $ypos[$j-1]) > 1){ #need to adjust vertical
        if($ypos[$j] > $ypos[$j-1]){
          $ypos[$j]--;
        }else{
          $ypos[$j]++;
        }
        if($xpos[$j] != $xpos[$j-1]){ # also horizontal 
          if($xpos[$j] > $xpos[$j-1]){
            $xpos[$j]--;
          }else{
            $xpos[$j]++;
          }
        }
      }
      
    }
 
    $TPOS{"$xpos[9],$ypos[9]"} = 1;
   
  }
  print "Moved $dir $num \n"; 
  print "xpos: @xpos; ypos @ypos\n"; 
 
}

my @posarray = keys %TPOS;
my $npos = $#posarray+ 1;
print "there are $npos positions\n";
