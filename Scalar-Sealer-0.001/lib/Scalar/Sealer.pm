package Scalar::Sealer;

use strict;
use warnings;
use Scalar::Sealed;

our @EXPORT_OK = qw(seal unseal);
our @ISA = qw(Exporter);

require Exporter;

our $VERSION = 0.001;

sub seal {
    my ($data) = @_;
    my ($seal,$unsealer) = Scalar::Sealed->new($data);
    return ($seal,$unsealer);
}

sub unseal {
    my ($seal,$unsealer) = @_;
    my $ret;
    die('Scalar::Sealer::unseal requires a Scalar::Sealed') unless ref $seal eq 'Scalar::Sealed';
    die('Scalar::Sealer::unseal requires a Scalar::Unsealer') unless ref $unsealer eq 'Scalar::Unsealer';
    eval { $ret = $seal->unseal($unsealer); };
    die("Scalar::Sealer::unseal: Invalid Unsealer") if $@;
    $ret;
}

1;
__END__

=head1 DESCRIPTION

Scalar::Sealer - Provides an implementation of Sealer/Unsealer pairs as inspired by the 'E' programming language for secure programming.

=head1 SYNOPSIS

 use Scalar::Sealer qw(seal unseal);
 
 my $foo = 1;
 my ($sealed_foo,$unsealer) = seal($foo);
 
 sub mult_foo {
    shift * 2; 
 }
 
 #Won't work, it'll die when it tries to multiply the seal
 print mult_foo($sealed_foo);
 
 #This is the original data, works fine
 print mult_foo($foo);
 
 #And the unsealed foo works fine too
 print mult_foo(unseal($sealed_foo,$unsealer)); 

=head1 ER... WHAT?

E is a secure programming language with an interesting concept called a sealer. The idea is that once a piece of data has been sealed, only a matching sealer can unseal it so it is usable again. You can visualise it as a chest, where the data gets locked in the chest and only the correct key (unsealer) can open it again.

The implementation attempts to uphold the security of the idea by storing all its data in lexical hashes in the inside-out-object format.

=head1 ER... WHY?

Because other languages are good to steal from

You should check E out here: L<http://en.wikipedia.org/wiki/E_%28programming_language%29>, noting the Purse example for seals in particular.

=head1 METHODS

=head2 seal ($data) -> (Scalar::Sealed,Scalar::Unsealer)

Seals a scalar, returning a Sealed scalar and an unsealer

=head2 unseal (Scalar::Sealed,Scalar::Unsealer) -> ($data)

Attempts to unseal the given sealed data with the given unsealer. Will die if they do not match.

=head1 COPYRIGHT & LICENSE

Copyright 2009 James Laver, all rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut