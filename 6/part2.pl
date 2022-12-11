#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my @charstream = split //, <FH>;

for(my $i=13;$i<$#charstream;$i++){
  my %seenhash=();
  my $failed=0;
  for(my $j=0;$j<14;$j++){
    if($seenhash{$charstream[$i-$j]} != 1){
      $seenhash{$charstream[$i-$j]} = 1;
    }else{
      $j=14; 
      $failed=1;
    }
  }
  
  if(!$failed){
    my $index = $i+1;
    print "$index\n";
    $i = $#charstream;
    
  }
}
