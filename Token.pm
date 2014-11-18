package PScm::Token;

use strict;
use warnings;
use base qw(PScm);

sub is_open_token { 0 }
sub is_close_token { 0 }

########################
package PScm::Token::Open;

use base qw(PScm::Token);

sub is_open_token { 1 }

########################
package PScm::Token::Close;

use base qw(PScm::Token);

sub is_close_token { 1 }
