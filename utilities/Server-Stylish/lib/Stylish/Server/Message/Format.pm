package Stylish::Server::Message::Format;
use Moose::Role;
use Stylish::Server::Message;

has 'message_class' => (
    is       => 'ro',
    isa      => 'ClassName',
    required => 1,
    default  => 'Stylish::Server::Message',
);

requires 'format';
requires 'parse';

around format => sub {
    my ($next, $self, $item) = @_;

    confess 'Only instances of Stylish::Server::Message can be formatted'
      unless blessed $item && $item->isa('Stylish::Server::Message');

    $self->$next([
        $item->command, {
            map { $_ => $item->get_argument($_) } $item->get_argument_list,
        },
    ]);
};

around parse => sub {
    my ($next, $self, $exp) = @_;

    my $data = $self->$next($exp);

    return $self->message_class->new(
        command   => $data->[0],
        arguments => $data->[1],
    );
};

1;
