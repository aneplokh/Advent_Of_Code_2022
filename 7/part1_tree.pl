#!/usr/bin/perl
use strict;
use Tree::Simple;
use Data::Dumper;

open(FH, $ARGV[0]);

my $tree = Tree::Simple->new("/", Tree::Simple->ROOT);
my $curr_pos = $tree;

while(<FH>){ #build tree
  chomp;
  my $line = $_;
  if ($line =~ m/^\$ cd (.*)/){ #cd operation
    my $dir = $1;
    if ($dir eq "/" ){
      $curr_pos = $tree;
    }elsif($dir eq ".."){
      $curr_pos = $curr_pos->getParent;
    }else{
      $curr_pos = $tree->getChild($dir);
    }
  }elsif($line =~ m/^\$ ls/){ #ls operation = basically a noop
  }elsif($line =~ m/dir ([a-z]+)/){ #it's a directory, create a new child if needed
    my $dir = $1;
    $curr_pos->addChild(Tree::Simple->new($dir));
  }elsif($line =~ m/([0-9]+) (.*)/){
    my $size = $1; my $filename = $2;
    $curr_pos->addChild(Tree::Simple->new($filename));
    $curr_pos->getChild($filename)->setNodeValue($size);
  }
}


$tree->traverse(sub {my ($_tree) = @_; my $tag = $_tree->getNodeValue(); print (("\t" x $_tree->getDepth()), $tag, "\n"); return 'ABORT' if 'foo' eq $tag;});

