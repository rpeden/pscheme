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