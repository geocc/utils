use strict;

my $alias = "$ENV{HOME}/configs/zsh/alias.zsh";

open(my $fh, '<', $alias) or die($!);

my %aliases;

while(<$fh>) {
  next if /^#/;
  if(m/^\s*alias\s+(\w+)=(?:'|")(.+)(?:'|")/) {
    $aliases{$1} = $2;
  }
}

for my $k(sort{ $aliases{$b} cmp $aliases{$a} } (keys(%aliases))) {
  print "alias $k='$aliases{$k}'\n";
}
