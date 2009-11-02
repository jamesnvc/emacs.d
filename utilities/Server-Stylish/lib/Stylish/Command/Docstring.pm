package Stylish::Command::Docstring;
use Moose::Role;
use MooseX::Method::Signatures;
use Class::MOP;
use feature 'switch';

use Stylish::Server::Message;

method command_docstring($client, :$package, :$type, :$argument) {
    my $docstring = $self->_get_docstring($package, $type, $argument);
    return message docstring => {
        documentation => $docstring,
    };
}

method _get_docstring($package, $type, $argument) {
    my $doc = sub {
        given($type){
            when('attribute'){
                eval { Class::MOP::load_class($package) };
                my $meta = eval { $package->meta };

                if($meta){
                    my $attr = $meta->get_attribute($argument);
                    if($attr){
                        my $doc = $attr->documentation;
                        return $doc if $doc;
                        return "No documentation found for ${package}::$argument";
                    }
                    return "No attribute $argument in $package";
                }
                return "No class $package!";
            }
        }
    }->();

    return $doc;
}

1;
