#!/usr/bin/perl 
use strict;
use File::Tail;

my $log   = shift;
my $line  = "";
my $tail  = File::Tail->new(name=>$log,
                            maxinterval=>3,
                            adjustafter=>3,
                            interval=>0,
                            tail=>100
                            );
while(defined($line=$tail->read)) {
  my $e = "(.+?)";
  $line =~ /^$e $e $e \[$e:$e $e\] "$e $e $e" $e $e/;

  my $ip      = $1;
  my $ref     = $2;
  my $name    = $3;
  my $date    = $4;
  my $time    = $5;
  my $gmt     = $6;
  my $request = $7;
  my $file    = $8;
  my $ptcl    = $9;
  my $code    = $10;
  my $size    = $11;

  $code = "\033[38;5;240m$code\033[0m" if $code == 404;
  $code = "\033[38;5;155m$code\033[0m" if $code == 200;
  $code = "\033[38;5;160m$code\033[0m" if $code == 501;
  $code = "\033[38;5;208m$code\033[0m" if $code == 301;
  $code = "\033[38;5;124m$code\033[0m" if $code == 403;
  $code = "\033[38;5;113m$code\033[0m" if $code == 304;
  $file = "" if $file =~ /^\/$/;
  $file = "\033[38;5;160m$file\033[0m" if $file !~ /([A-Za-z0-9])+/;
  $size = "\033[38;5;160m$size\033[0m" if $size > 5;
  printf("%s %7s %s %s %60s\n",
  $code, $request, $size, $ip, $file);
}
