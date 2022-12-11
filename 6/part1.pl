#!/usr/bin/perl
use strict;

open(FH, $ARGV[0]);

my @charstream = split //, <FH>;

for(my $i=3;$i<$#charstream;$i++){
  if($charstream[$i] ne $charstream[$i-1] && $charstream[$i] ne $charstream[$i-2] && $charstream[$i] ne $charstream[$i-3] &&
     $charstream[$i-1] ne $charstream[$i-2] && $charstream[$i-1] ne $charstream[$i-3] && $charstream[$i-2] ne $charstream[$i-3]){
    my $index = $i+1;
    print "$index\n";
    $i = $#charstream;
  }
}
