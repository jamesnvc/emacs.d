#!/usr/local/bin/perl -i.bak
#$Id: byte-dont-compile-dynamic.pl 4047 2006-08-11 19:11:17Z tv.raman.tv $
#Turn off dynamic loading on specified file
while ( <>) {
  print;
  if (m/^;;; byte-compile-dynamic: t$/) {
    print ";;; byte-compile-dynamic: nil\n";
  }
}
