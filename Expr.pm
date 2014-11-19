package PScm::Expr;

use strict;
use warnings;
use base qw(PScm::Token);

sub isTrue {
	my ($self) = @_;
	scalar($self->value);
}

sub Eval {
	my ($self) = @_;
	return $self;
}

sub value { $_[0] }