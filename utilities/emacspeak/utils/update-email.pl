#!/usr/local/bin/perl -i.bak
#$Id: update-email.pl 4047 2006-08-11 19:11:17Z tv.raman.tv $
#Update my email
#
my $old =  "raman\@adobe.com";
my $new = "raman\@cs.cornell.edu";
while (<>) {
    s/$old/$new/o;
    print;
}
