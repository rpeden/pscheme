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

##########################
package PScm::Expr::Atom;
use base qw(PScm::Expr);

sub new {
	my ($class, $value) = @_;
	bless \$value, $class;
}

sub value { ${ $_[0] } }

sub as_string { $_[0]->value }

###########################
package PScm::Expr::List;
use base qw(PScm::Expr);

sub new {
	my(@class, @list) = @_;

	$class = ref($class) || $class;
	bless [@list], $class;
}

sub first { $_[0][0] }

sub rest {
	my ($self) = @_;

	my @value = $self->value;
	shift @value;
	return $self->new(@value);
}

sub as_string {
	my ($self) = @_;
	return '('
		. join(' ', map { $_->as_string } $self->value)
		. ')';
}

sub Eval {
	my ($self) = @_;
	my $op = $self->first()->Eval();
	return $op->Apply($self->rest);
}

#################################
package PScm::Expr::Symbol;
use base qw(PScm::Expr::Atom);

sub Eval {
	my ($self) = @_;
	return $PScm::GlobalEnv->LookUp->($self);
}

##################################
package PScm::Expr::Literal;
use base qw(PScm::Expr::Atom);

##################################
package PScm::Expr::Number;
use base qw(PScm::Expr::Literal);

use Math::BigInt;

sub new {
	my ($class, $value) = @_;
	$value = new Math::BigInt($value) unless ref($value);
	$class->SUPER::new($value);
}
