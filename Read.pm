package PScm::Read;

use strict;
use warnings;
use PScm::Expr;
use PScm::Token;
use base qw(PScm);

sub new {
	my ($class, $fh) = @_;

	bless {
		FileHandle => $fh,
		Line 	   => '',
	}, $class;
}