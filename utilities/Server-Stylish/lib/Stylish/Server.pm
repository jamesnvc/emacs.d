package Stylish::Server;

use AnyEvent;
use AnyEvent::Socket;

use Moose;
use MooseX::AttributeHelpers;
use Moose::Util::TypeConstraints qw/subtype/;

use Set::Object;

use Stylish::Server::Connection;

use namespace::clean -except => 'meta';

our $VERSION = '0.01';

with qw/MooseX::LogDispatch/;

subtype PortNumber => Int => sub { $_ > 0 && $_ < 65536 };

has 'port' => (
    is      => 'ro',
    isa     => 'PortNumber',
    default => '36227',
);

has 'clients' => (
    is      => 'ro',
    isa     => 'Set::Object',
    default => sub {
        Set::Object->new;
    },
);

sub run {
    my $self = shift;
    $self->logger->debug( "Starting server on port ". $self->port );
    tcp_server undef, $self->port, sub {
        my ($fh, $host, $port) = @_;
        $self->logger->debug( "$host:$port connected" );

        my $connection = Stylish::Server::Connection->new(
            handle => $fh,
        );

        $self->clients->insert($connection);
    };
}

1;
