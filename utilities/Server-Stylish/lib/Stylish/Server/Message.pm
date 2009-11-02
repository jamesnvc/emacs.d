package Stylish::Server::Message;
use Moose;
use Moose::Util::TypeConstraints;
use MooseX::AttributeHelpers;

use namespace::clean -except => 'meta';

sub import {
    my $caller = scalar caller;
    no strict;
    *{ "${caller}::message" } = sub($$){
        use strict;
        my ($command, $args_ref) = @_;
        return __PACKAGE__->new( command => $command, arguments => $args_ref );
    };
}

subtype Symbol => as 'Str' => where { /^:?[A-Za-z_]+$/ };

has 'command' => (
    is       => 'ro',
    isa      => 'Symbol',
    required => 1,
);

has 'arguments' => (
    metaclass => 'Collection::ImmutableHash',
    is        => 'ro',
    isa       => 'HashRef[Str]',
    default   => sub { +{} },
    provides  => {
        get  => 'get_argument',
        keys => 'get_argument_list',
    },
);

1;
