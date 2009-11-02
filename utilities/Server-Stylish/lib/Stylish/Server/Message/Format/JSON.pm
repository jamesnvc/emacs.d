package Stylish::Server::Message::Format::JSON;
use Moose;

use JSON::Any;

has 'json' => (
    is      => 'ro',
    isa     => 'JSON::Any',
    default => sub { JSON::Any->new },
    handles => {
        format => 'Dump',
        parse  => 'Load',
    },
);

with 'Stylish::Server::Message::Format';

1;
