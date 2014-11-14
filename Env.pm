package PScm::Env;

use strict;
use warnings;
use base qw(PScm);

sub new {
	my ($class, %bindings) = @_;

	bless { bindings => {%bindings}, }, $class;
}

sub LookUp {
	my ($self, $symbol) = @_;

	if(exists($self->{bindings}{ $symbol->value })){
	   return $self->{bindings}{ $symbol->value };
	} else {
		die "no binding for @{[$symbol->value]} ",
			"in @{[ref($self)]}\n";
	}
}