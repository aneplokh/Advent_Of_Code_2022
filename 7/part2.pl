#!/usr/bin/perl
use strict;
use Data::Dumper;

open(FH, $ARGV[0]);

my @path = ("root");
my %dirsize=();

while(<FH>){
  chomp;
  my $line = $_;
  if($line =~ m/^\$ cd (.*)/){
    my $dir = $1;
    if($dir eq "/"){
      @path=("root");
    }elsif($dir eq ".."){
      pop(@path);
    }else{
      push(@path, $dir);
    }
  }elsif($line =~ m/^\$ ls/){ #basically a no-op
    #print "listing files in @path\n";
    my $longpath = join "/", @path;
    $dirsize{$longpath} += 0;
  }else{
    if($line =~ m/dir (.*)/){ #also can ignore this
      my $dir = $1;
    }elsif($line =~ m/(\d+) (.*)/){
      my $size = $1; my $fn = $2;
      my $longpath = join "/", @path;
      $dirsize{$longpath} += $size;
    }else{
      die "did not understand $line\n";
    }
  }
}

my $totalsize = 0;

foreach my $p (sort {length($b) <=> length($a)} keys %dirsize){
  
  if($p ne "root"){
    my @paths = split /\//, $p;
    my $currsize = $dirsize{$p};
    pop @paths;
    my $one_up = join "/", @paths;
    $dirsize{$one_up} += $currsize;
  }
}

my $rootsize = $dirsize{"root"};
my $available_space = 70000000 - $rootsize;
my $needed = 30000000 - $available_space;

my $current_winner = 999999999999;
foreach my $p (keys %dirsize){
  if($dirsize{$p} > $needed && $dirsize{$p} < $current_winner){
    $current_winner=$dirsize{$p};
  }
 
}


print "answer: $current_winner\n";
