package Stylish::Command::Id;
use Moose::Role;
use MooseX::Method::Signatures;
use Stylish::Server::Message;

method command_id($client){
    return message id => {
        session_id => $client,
    };
};

1;
