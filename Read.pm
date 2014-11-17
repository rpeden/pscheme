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

sub Read {
	my ($self) = @_;

	my $token = $self->_next_token();
	return undef unless defined $token;

	return $token unless $token->is_open_token;

	my @res = ();

	while(1) {
		$token = $self->Read;
		die "unexpected EOF" if !defined $token;
		last if $token->is_close_token;
		push @res, $token;
	}

	return new PScm::Expr::List(@res);
}

sub _next_token {
	my($self) @_;

	while (!$self->{Line}) {
		$self->{Line} = $self->{FileHandle}->getline();
		return undef unless defined $self->{Line};
		$self->{Line} =~ s/^\s+//s;
	}

	for ($self->{Line}) {
		s/^\(\s*// && return PScm::Token::Open->new();
		s/^\)\s*// && return PScm::Token::Close->new();
		s/^([-+]?\d+)\s*// && return PScm::Expr::Number->new($1);
		s/^"((?:(?:\\.)|([^"]))*)"\s*// && do {
			my $string = $1;
			$string =~ s/\\//g;
			return PScm::Expr::String->new($string);
		}
		s/^([^\s(\)]+)\s*//
			&& return PScm::Expr::Symbol->new($1);
	}
	die "can't parse: $self->{Line}";
}
