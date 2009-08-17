package Scalar::Unsealer;

use strict;
use warnings;

sub new {
    my ($class) = @_;
    my $self = bless \( my $dummy ),$class;
}

sub unseal {
    my ($self,$sealed) = @_;
    die("Unsealer::unseal: requires a Scalar::Sealed") unless ref $sealed eq 'Scalar::Sealed';
    eval {
        return $sealed->unseal($self);
    };
    #If it died, give the error message for this package instead
    die("Scalar::Unsealer::unseal called on an unmatching seal") if $@;
}

1;
__END__

=head1 DESCRIPTION

Scalar::Unsealer - Unseals a Data::Sealed (seal) sealed by Data::Sealer (sealer)

=head1 METHODS

=head2 new

You shouldn't call this directly, use Scalar::Sealer

=head2 unseal ($seal) :: Scalar::Sealed -> a

Unseals the seal provided, if it matches the unsealer.

=head1 SEE ALSO

L<Scalar::Sealer> - E-like Seals for Secure Programming

=head1 COPYRIGHT & LICENSE

Copyright 2009 James Laver, all rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut