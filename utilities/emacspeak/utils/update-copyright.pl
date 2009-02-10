#!/usr/bin/perl -i
#$Id: update-copyright.pl 4532 2007-05-04 01:13:44Z tv.raman.tv $
#Update Copyright notice
#

my $old = "1995 -- 2007, T. V. Raman";
my $new = "1995 -- 2007, T. V. Raman";

while (<>) {
    s/$old/$new/o;
    print;
}
