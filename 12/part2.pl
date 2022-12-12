#!/usr/bin/perl
use strict;
use Data::Dumper;

open(FH, $ARGV[0]);

my %map;
my $startcell;
my $endcell;

#build map

my $maxy=0;
my $maxx = 0;

while(<FH>){
  chomp;
  my @row = split //, $_;
  for(my $x=0; $x<=$#row; $x++) { 
    if ($row[$x] =~ m/[a-z]/){
      $map{"$x,$maxy"} = ord($row[$x]) - ord('a');
    }elsif($row[$x] eq "S"){
      $map{"$x,$maxy"} = ord('a')-ord('a');
      $startcell = "$x,$maxy";
    }elsif($row[$x] eq "E"){
      $map{"$x,$maxy"} = ord('z')-ord('a');
      $endcell = "$x,$maxy";
    }else{
      die "unexpected value in @row\n";
    }
    $maxx=$x;
  }
  $maxy++;
}

$maxy--; 

#now build valid paths

my %validpaths;
my %shortest_path_to_cell;

for(my $x=0;$x<=$maxx;$x++){
  for(my $y=0;$y<=$maxy;$y++){
    $shortest_path_to_cell{"$x,$y"} = 999999; 
    if($x !=0){ #look up
      my $upx = $x-1;
      if($map{"$x,$y"} + 1 >= $map{"$upx,$y"}){
        push @{$validpaths{"$x,$y"}}, "$upx,$y";
      }
    }
    if($y !=0) { #look left
      my $lefty = $y-1;
      if($map{"$x,$y"} +1 >= $map{"$x,$lefty"}){
        push @{$validpaths{"$x,$y"}}, "$x,$lefty";
      }
    }
    if($x != $maxx){#look down
      my $downx = $x+1; #no loops, no dead ends
      if($map{"$x,$y"} +1  >= $map{"$downx,$y"}){
        push @{$validpaths{"$x,$y"}}, "$downx,$y";
      }
    }
    if($y != $maxy){#look right
      my $righty = $y+1;
      if($map{"$x,$y"} +1 >= $map{"$x,$righty"}){
        push @{$validpaths{"$x,$y"}}, "$x,$righty";
      }
    }
 
  }
}

#now start at A and see where we go from there
my @dead_end;
my @successful_path;
my $minhops=999999;

for(my $x=0;$x<=$maxx;$x++){
  for(my $y=0;$y<=$maxy;$y++){
    if($map{"$x,$y"} == 0 ){
      traverse("$x,$y",());
    }
  }
}


print "minimum hops required: $minhops\n";



sub traverse(){
  my $thiscell = shift;
  my @visited = @_;

  push @visited, $thiscell; #add this to the list of cells visited
  if($#visited < $minhops){ #only continue if we have a chance at the shortest path

    foreach my $nextcell (@{$validpaths{$thiscell}}){
      if($nextcell eq $endcell){
        #print "found a path, took $#visited + 1 hops\n";
        if($minhops > $#visited+1){
          $minhops = $#visited+1;
        }
      }elsif($shortest_path_to_cell{$nextcell} > $#visited){ #only if this would be the shortest path
          $shortest_path_to_cell{$nextcell} = $#visited;
          traverse($nextcell, (@visited));
      }

    }
  }
}

