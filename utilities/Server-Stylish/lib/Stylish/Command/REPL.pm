package Stylish::Command::REPL;
use Moose::Role;
use MooseX::Method::Signatures;

use Stylish::REPL;
use File::Slurp qw(read_file);
use IO::CaptureOutput qw(capture);

use Stylish::Server::Message;

has 'REPL' => (
    is      => 'ro',
    isa     => 'Stylish::REPL',
    default => sub {
        Stylish::REPL->new;
    },
);

method command_repl($client, :$command){
    my ($stdout, $stderr, $result);
    capture {
        $result = $self->REPL->run_once($command);
    } \$stdout, \$stderr;

    return message repl => {
        status => 'success', # XXX: error should also be handled
        result => q{}. $result,
        stdout => $stdout,
        stderr => $stderr,
    };
}

method command_repl_load_file($client, :$filename) {
    # read the file in manually so we can add a "1;" at the end
    my $text = eval { read_file $filename } || qq{die "Could not read \Q'$filename'"};
    return $self->command_repl($client, qq{$text ;"Loaded \Q$filename\E OK";});
}

1;
