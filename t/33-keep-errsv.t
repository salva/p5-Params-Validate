use strict;
use warnings;

use Params::Validate qw( validate SCALAR );

use Test::More;

$@ = 'foo';
v(bar => "doz");

is ( $@,
     'foo',
     'do not clobber $@ from validate'
);

done_testing;

sub v {
    validate( @_, { bar => { type => SCALAR } })
}
