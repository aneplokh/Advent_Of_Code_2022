#!/usr/bin/perl
use strict;
use POSIX qw /floor/;

open(FH, $ARGV[0]);
my %monkey_items; 
my @monkey_operation_type;
my @monkey_operation_value;
my @monkey_test;
my @monkey_true;
my @monkey_false;

my @monkey_inspected;

while(<FH>){
 
  if($_ =~ m/Monkey (\d+):/){
    my $m = $1;
    my $line = <FH>;

    if($line =~ m/Starting items: (.*)/){
      my @items = split /,/, $1;
      @{$monkey_items{$m}} = @items; 
    }else{
      die "unexpected starting items $!\n";
    }

    $line = <FH>; # Operation: new = old * 3 
    if($line =~ m/Operation: new = old ([\+\*]) ([a-z0-9]+)/){
      push(@monkey_operation_type, $1);
      push(@monkey_operation_value, $2); 
    }else{
      die "unexpected operation $line\n";
    }
    $line= <FH>; #Test: divisible by 13
    if($line =~ m/Test: divisible by (\d+)/){
      push(@monkey_test, $1);
    }else{
      die "unexpected test $!\n";
    }
    
    $line= <FH>; #If true: throw to monkey 6
    if($line =~ m/If true: throw to monkey (\d+)/){
      push(@monkey_true, $1);
    }else{
      die "unexpected true $!\n";
    }
    
    $line= <FH>; #If false: throw to monkey 2

    if($line =~ m/If false: throw to monkey (\d+)/){
      push(@monkey_false, $1);
    }else{
      die "unexpected false $!\n";
    }

    $line = <FH>;#eating the blank line before continuing
    
  }else{
    die "unexpected input $!\n";
  }
}

my $LCM=1;

foreach my $mult (@monkey_test){
  $LCM *= $mult; 
}


for (my $i=1;$i <= 10000; $i++){
  foreach my $m (sort keys %monkey_items){
  
    while( my $item_value = shift  @{$monkey_items{$m}}){
 
     $monkey_inspected[$m]++;
  
      #first perform operation
      if($monkey_operation_type[$m] eq "+"){
        if($monkey_operation_value[$m] eq "old"){
          $item_value += $item_value;
        }else{
          $item_value += $monkey_operation_value[$m];
        }
      }elsif($monkey_operation_type[$m] eq "*"){
        if($monkey_operation_value[$m] eq "old"){
          $item_value *= $item_value;
        }else{
          $item_value *= $monkey_operation_value[$m];
        }
      }
      #then divide by 3; #NOT IN PART 2
      #$item_value = floor($item_value/3);
      #then run test

      $item_value = $item_value % $LCM;

      my $next_monkey;
      if($item_value % $monkey_test[$m] == 0){
        $next_monkey = $monkey_true[$m];
      }else{
        $next_monkey = $monkey_false[$m];
      }
     
      push @{$monkey_items{$next_monkey}}, $item_value; 
  
    }
  }

#  print "round $i\n";  
#  foreach my $m (sort keys %monkey_items){
#    print "$m: @{$monkey_items{$m}}\n";
#  }

}

my @sorted = sort {$b <=> $a} @monkey_inspected;
my $answer = $sorted[0]*$sorted[1];

print "Level of Moneky Business: $answer\n";
