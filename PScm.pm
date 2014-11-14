package PScm;

use strict;
use warnings;
use PScm::Read;
use PScm::Env;
use PScm::Primitive;
use PScm::SpecialForm;
use FileHandle;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(ReadEvalPrint);

=head1 NAME

PScm - A fun schemish language written in Perl

=head1 SYNOPSIS

  use PScm;
  ReadEvalPrint($in_filehandle[, $out_filehandle]);

 =head1 DESCRIPTION

 A fun toy lisp interpreter. Using as practice because
 I Want to implement an evem better one. 

 =cut

our $GlobalEnv = new PScm::Env(
	'*' => new PScm::Primitive::Multiply(),
	'-' => new PScm::Primitive::Subtract(),
	if  => new PScm::SpecialForm::If(),
);