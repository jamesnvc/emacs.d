package Stylish::Command::Syntax;
use Moose::Role;

use Stylish::Syntax::PPI;
use Stylish::Server::Message;

sub command_highlight {
    my ($self, $client, $tag, $offset, $code) = @_;
    my $doc = Stylish::Syntax::PPI->new(document => $code, offset => $offset);
    return message highlight => {
        tag    => $tag,
        result => $doc->syntax,
    };
}

1;
