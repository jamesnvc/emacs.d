#!/usr/local/bin/perl -i.bak
#$Id: byte-compile-dynamic.pl 4047 2006-08-11 19:11:17Z tv.raman.tv $
#Let's  turn on dynamic loading 
while ( <>) {
  print;
  if ( m/^;;; folded-file: t$/) {
    print ";;; byte-compile-dynamic: t\n";
  }
}
