use strict;
use warnings;
use Test::More tests => 7;

use ok 'Stylish::Server::Message';
use ok 'Stylish::Server::Message::Format';
use ok 'Stylish::Server::Message::Format::JSON';

my $msg = Stylish::Server::Message->new(
    command   => 'foo_bar',
    arguments => {
        foo => 42,
        bar => 69,
    },
);

isa_ok $msg, 'Stylish::Server::Message';

my $json = Stylish::Server::Message::Format::JSON->new;
is $json->format($msg), q|["foo_bar",{"bar":69,"foo":42}]|;

my $msg2 = $json->parse(q|["some_command",{"foo":42}]|);
is $msg2->command, 'some_command';
is $msg2->get_argument('foo'), 42;
