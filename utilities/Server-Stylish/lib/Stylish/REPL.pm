package Stylish::REPL;
use Moose;
use 5.010;

extends 'Devel::REPL';

with qw/Devel::REPL::Plugin::LexEnv
        Devel::REPL::Plugin::DDS/;

# XXX: this should be a "profile"

1;
