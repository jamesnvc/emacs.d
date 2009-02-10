#!/usr/bin/perl -i
#$Id: v2p.pl 4047 2006-08-11 19:11:17Z tv.raman.tv $
#change voice-lock to emacspeak-personality 
my $old="require \'voice-lock";
my $new="require \'emacspeak-personality";
while ( <>) {
  s/$old/$new/go;
print;
}
