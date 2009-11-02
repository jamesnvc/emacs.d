#!/usr/bin/env perl

use Stylish::Server;
use EV;

my $server = Stylish::Server->new->run;
EV::loop();
