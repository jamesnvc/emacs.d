package Stylish::Server::Connection;
use Moose;
use Moose::Util::TypeConstraints qw/class_type coerce via/;

use AnyEvent;
use AnyEvent::Handle;

use Scalar::Util qw(refaddr);

use Stylish::REPL;
use Stylish::Server::Message;

use namespace::clean -except => 'meta';

with qw/
        MooseX::LogDispatch
        Stylish::Command::Id
        Stylish::Command::Syntax
        Stylish::Command::REPL
        Stylish::Command::Docstring
       /;

class_type 'AnyEvent::Handle';
coerce 'AnyEvent::Handle', 'GlobRef', via {
    AnyEvent::Handle->new(
        fh => $_,
    );
};

has 'handle' => (
    is       => 'ro',
    isa      => 'AnyEvent::Handle',
    required => 1,
    coerce   => 1,
);

has 'repl' => (
    is      => 'ro',
    isa     => 'Stylish::REPL',
    default => sub {
        Stylish::REPL->new;
    },
);

has 'formatter' => (
    is        => 'ro',
    does      => 'Stylish::Server::Message::Format',
    default   => sub {
        require Stylish::Server::Message::Format::JSON;
        return  Stylish::Server::Message::Format::JSON->new;
    },
);


sub BUILD {
    my $self = shift;
    my $push;
    my $cb = sub {
        my ($h, $data) = @_;
        $self->read($data);
        $push->();
    };

    $push = sub {
        $self->handle->push_read( line => "\n", $cb );
    };

    $push->();

    $self->write( message welcome => {
        version      => "Stylish $Stylish::Server::VERSION",
        'session-id' => refaddr $self->handle,
    });
}

sub read {
    my ($self, $input) = @_;

    $self->logger->debug('Got data: ', @_);

    my $result = eval {
        my $request = $self->formatter->parse($input);

        $self->logger->debug("Request: $input");
        my $method = "command_". $request->command;
        my @args = map { $_, $request->get_argument($_) } $request->get_argument_list;

        # XXX: undef for "back compat", will be deprecated in about 10
        # minutes :)
        my $response = $self->$method(undef, @args);

        return $response;
    };

    $result ||= Stylish::Server::Message->new(
        command   => 'error',
        arguments => { parse_error => $@ },
    );

    $self->write($result);

}

sub write {
    my ($self, $msg) = @_;
    my $res = $self->formatter->format($msg);

    $self->logger->debug('Response:', $res);
    $self->handle->push_write($res."\r\n");

}

1;
