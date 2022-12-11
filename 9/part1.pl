#!/usr/bin/perl

use strict;

open (FH, $ARGV[0]);

my %TPOS;

$TPOS{"0,0"}=1;

my $hposx=0;
my $hposy=0;
my $tposx=0;
my $tposy=0;

while(<FH>){
  chomp;
  my ($dir,$num) = split /\s+/, $_;

  for(my $i=1;$i<=$num;$i++){
    if($dir eq "R"){
      $hposx += 1; 
      if(abs($tposx-$hposx) > 1){
        if($tposy == $hposy){ #same row, move straight
          $tposx +=1;
        }elsif($tposy>$hposy){
          $tposy -=1;  
          $tposx +=1;
        }else{
          $tposy +=1;  
          $tposx +=1;
        }
      }
    }elsif($dir eq "L"){
      $hposx -= 1; 
      if(abs($tposx-$hposx) > 1){
        if($tposy == $hposy){ #same row, move straight
          $tposx -=1;
        }elsif($tposy>$hposy){
          $tposy -=1;  
          $tposx -=1;
        }else{
          $tposy +=1;  
          $tposx -=1;
        }
      }
    }elsif($dir eq "D"){
      $hposy -= 1; 
      if(abs($tposy-$hposy) > 1){
        if($tposx == $hposx){ #same row, move straight
          $tposy -=1;
        }elsif($tposx>$hposx){
          $tposy -=1;  
          $tposx -=1;
        }else{
          $tposx +=1;  
          $tposy -=1;
        }
      }
    }elsif($dir eq "U"){
      $hposy += 1; 
      if(abs($tposy-$hposy) > 1){
        if($tposx == $hposx){ #same row, move straight
          $tposy +=1;
        }elsif($tposx>$hposx){
          $tposy +=1;  
          $tposx -=1;
        }else{
          $tposx +=1;  
          $tposy +=1;
        }
      }
    }else{
      print "you messed something up\n";
    }
 
    $TPOS{"$tposx,$tposy"} = 1;
   
  }
 
}

my @posarray = keys %TPOS;
my $npos = $#posarray+ 1;
print "there are $npos positions\n";
