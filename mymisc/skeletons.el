(define-skeleton factor-skeleton
    "Insert boilerplate for a new factor module"
  "Module name: "
  "! Copyright (C) 2008 James Cash" ?\n
  "! See http://factorcode.org/license.txt for BSD license." ?\n
  "USING: kernel ;" ?\n
  "IN: " str | (file-name-sans-extension (buffer-name)) ?\n ?\n
  _
)

(define-skeleton latex-preamble-skeleton
    "Inserts the standard boilerplate for a new LaTeX doc"
  "Title: "
  "\\documentclass{article}"\n
  "\\title{"str"}"\n
  "\\author{James Cash}"\n \n
  "\\begin{document}"\n
  "\\maketitle"\n
  _ \n \n
  "\\end{document}"
  )

(define-skeleton latex-begin-skeleton
  "Inserts balanced begin/end"
  "Section: "
  "\\begin{" str "}" \n 
  _ \n
  "\\end{" str "}"
)


(define-skeleton perl-application-skeleton
  "Inserts the standard Perl application template"
  "Application name: "
  "#!/usr/bin/env perl"\n
  "use strict;"\n
  "use warnings;"\n \n
  _ \n \n
  "__END__"\n \n 
  "=head1 NAME"\n \n
  str" - <One line description of application's purpose>"\n \n
  "=head1 VERSION"\n \n
  "This documentation refers to "str" version 0.0.1"\n \n
  "=head1 SYNOPSIS"\n \n
  > "# brief invocations, showing most common usage" \n \n
  "=head1 EXAMPLES"\n \n
  "Some example of usage"\n \n
  "=head1 REQUIRED ARGUMENTS" \n \n
  "A complete list of every argument that must apppear on the command line when the app is invoked" \n \n
  "=head1 OPTIONS" \n \n
  "A complete list of every availible option with which the application can be invoked." \n \n
  "=head1 DESCRIPTION"\n \n
  "A full description of the application and its features (include subsections, eg =head2,3)"\n \n
  "=head1 DIAGNOSTICS"\n \n
  "A list of every error and warning message that the application can generate"\n \n
  "=head1 CONFIGURATION AND ENVIRONMENT"\n \n
  "A fullexplanation of any configuration system(s) used by the application, including the names and locations of any configuration files"\n \n
  "=head1 DEPENDENCIES"\n \n
  "A list of all the other modules that this application relies upon, including any restrictions on versions, and an indication of where to get them"\n \n
  "=head1 INCOMPATIBILITIES"\n \n
  "A list of any modules that this application cannot be used in conjunction with"\n \n
  "=head1 BUGS AND LIMITATIONS"\n \n
  "There are undoubtedly serious bugs lurking somewhere in this code."\n
  "Bug reports and other feedback are most welcome."\n \n
  "=head1 COPYRIGHT & LICENSE"\n \n
  "Copyright 2008 James Cash, all rights reserved."\n \n
  "This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself."\n \n
  "=head1 AUTHOR" \n \n
  "James Cash, C<< <james.nvc at gmail.com> >>"
  )