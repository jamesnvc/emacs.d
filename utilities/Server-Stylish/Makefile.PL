use inc::Module::Install;

name 'Stylish';
all_from 'lib/Stylish.pm';

requires 'AnyEvent';
requires 'Devel::REPL';
requires 'EV';
requires 'File::Slurp';
requires 'IO::CaptureOutput';
requires 'JSON::Any';
requires 'Moose';
requires 'Moose::Util::TypeConstraints';
requires 'MooseX::LogDispatch';
requires 'MooseX::Method::Signatures';
requires 'PPI';
requires 'Time::HiRes';
build_requires 'Test::More';
build_requires 'ok';

tests 't/format/*.t t/syntax/*.t t/*.t';

WriteAll();
