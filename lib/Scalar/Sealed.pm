package Scalar::Sealed;

use strict;
use warnings;

use Carp;

use Scalar::Unsealer;

use overload
    '+' => \&_die,
    '-' => \&_die,
    '*' => \&_die,
    '/' => \&_die,
    '%' => \&_die,
    '**' => \&_die,
    '<<' => \&_die,
    '>>' => \&_die,
    'x' => \&_die,
    '<=>' => \&_die,
    'cmp' => \&_die,
    '&' => \&_die,
    '^' => \&_die,
    '|' => \&_die,
    '~' => \&_die,
    '.' => \&_die,
    'atan2' => \&_die,
    'cos' => \&_die,
    'sin' => \&_die,
    'exp' => \&_die,
    'log' => \&_die,
    'sqrt' => \&_die,
    '<>' => \&_die,
    '${}' => \&_die,
    '@{}' => \&_die,
    '%{}' => \&_die,
    '&{}' => \&_die,
    '*{}' => \&_die,
    '<>' => \&_die,
    'fallback' => 1;
#    '""' => \&_die;
#    'int' => \&_die,
#    'bool' => \&_die,
my %data;
my %unsealers;

sub new {
    my ($classname,$data) = @_;
    my $unsealer = Scalar::Unsealer->new;
    my $self = bless \(0+$unsealer), $classname;
    $unsealers{$self} = 0+$unsealer;
    $data{$self} = $data;
    return ($self,$unsealer);
}

sub unseal {
    my ($self,$unsealer) = @_;
    confess("Scalar::Sealed::unseal requires a Scalar::Unsealer") unless ref $unsealer eq 'Scalar::Unsealer';
    confess("Scalar::Sealed::unseal requires the corresponding unsealer") unless $unsealers{$self} eq 0+$unsealer;
    return $data{$self};
}

sub _die {
    confess("Cannot operate on a Scalar::Sealed, it must be unsealed first with the corresponding unsealer");
}

sub DESTROY {
    my ($self) = @_;
    undef $data{$self};
    undef $unsealers{$self};
}

1;
__END__

=head1 DESCRIPTION

Scalar::Sealed - Data sealed by Scalar::Sealer

=head1 METHODS

=sub new($data) -> (Scalar::Sealed, Scalar::Unsealer)

Returns the sealed data and a matching unsealer

=sub unseal (Scalar::Unsealer) -> data

Attempts to unseal the data with the provided seal, else dies.

=head1 COPYRIGHT & LICENSE

Copyright 2009 James Laver, all rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut