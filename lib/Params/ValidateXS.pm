package Params::Validate;

use strict;

require Exporter;
require DynaLoader;

use vars qw( $VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS %OPTIONS $options );
@ISA = qw(Exporter DynaLoader);

my %tags =
    ( types =>
      [ qw( SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF
            SCALARREF HANDLE BOOLEAN UNDEF OBJECT ) ],
    );

%EXPORT_TAGS =
    ( 'all' => [ qw( validate validate_pos validation_options validate_with ),
                 map { @{ $tags{$_} } } keys %tags ],
      %tags,
    );

@EXPORT_OK = ( @{ $EXPORT_TAGS{all} }, 'set_options' );
@EXPORT = qw( validate validate_pos );

bootstrap Params::Validate $Params::Validate::VERSION;

{
    my %defaults = ( ignore_case   => 0,
		     strip_leading => 0,
		     allow_extra   => 0,
		     on_fail       => sub { require Carp;
                                            Carp::confess($_[0]) },
		     stack_skip    => 1,
		   );

    *set_options = \&validation_options;
    sub validation_options
    {
	my %opts = @_;

	my $caller = caller;

	foreach ( keys %defaults )
	{
	    $opts{$_} = $defaults{$_} unless exists $opts{$_};
	}

	$OPTIONS{$caller} = \%opts;
    }
}

1;

__END__

=head1 NAME

Params::ValidateXS - XS implementation of Params::Validate

=head1 DESCRIPTION

This is an XS implementation of Params::Validate.  See the
Params::Validate documentation for details.

=head1 AUTHOR

Dave Rolsky, <autarch@urth.org> and Ilya Martynov, <ilya@martynov.org>

=cut