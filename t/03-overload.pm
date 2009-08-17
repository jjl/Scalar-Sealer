use Test::More tests => 63;

use Scalar::Sealer qw(seal unseal);

my $foo = 'foo';
my ($s,$u) = seal($s);

#Arithmetic
eval {$s + 1};
isnt($@,'','+');
eval {$s += 1};
isnt($@,'','+=');
eval {$s +- 1};
isnt($@,'','-');
eval {$s -= 1};
isnt($@,'','-=');
eval {$s * 1};
isnt($@,'','*');
eval {$s *= 1};
isnt($@,'','*=');
eval {$s / 1};
isnt($@,'','/');
eval {$s /= 1};
isnt($@,'','/=');
eval {$s % 1};
isnt($@,'','%');
eval {$s %= 1};
isnt($@,'','%=');
eval {$s ** 1};
isnt($@,'','**');
eval {$s **= 1};
isnt($@,'','**=');
eval {$s << 1};
isnt($@,'','<<');
eval {$s <<= 1};
isnt($@,'','<<=');
eval {$s >> 1};
isnt($@,'','>>');
eval {$s >>= 1};
isnt($@,'','>>=');
eval {$s x 1};
isnt($@,'','x');
eval {$s x= 1};
isnt($@,'','x=');
eval {$s . 1};
isnt($@,'','.');
eval {$s .= 1};
isnt($@,'','.=');

#Comparison
eval {$s < 1};
isnt($@,'','<');
eval {$s <= 1};
isnt($@,'','<=');
eval {$s > 1};
isnt($@,'','>');
eval {$s >= 1};
isnt($@,'','>=');
eval {$s == 1};
isnt($@,'','==');
eval {$s != 1};
isnt($@,'','!=');
eval {$s + 1};
isnt($@,'','<=>');
eval {$s lt 1};
isnt($@,'','lt');
eval {$s le 1};
isnt($@,'','le');
eval {$s gt 1};
isnt($@,'','gt');
eval {$s ge 1};
isnt($@,'','ge');
eval {$s eq 1};
isnt($@,'','eq');
eval {$s ne 1};
isnt($@,'','ne');
eval {$s cmp 1};
isnt($@,'','cmp');

#Bitwise
eval {$s & 1};
isnt($@,'','&');
eval {$s &= 1};
isnt($@,'','&=');
eval {$s ^ 1};
isnt($@,'','^');
eval {$s ^= 1};
isnt($@,'','^=');
eval {$s | 1};
isnt($@,'','|');
eval {$s |= 1};
isnt($@,'','|=');
eval {-$s};
isnt($@,'','neg');
eval {!$s};
isnt(!$@,'','!');
eval {~$s};
isnt($@,'','~');

#{In,De}crement
eval {$s++};
isnt($@,'','++');
eval {$s--};
isnt($@,'','--');

#Transcendental
eval {atan $s};
isnt($@,'','atan');
eval {cos $s};
isnt($@,'','cos');
eval {sin $s};
isnt($@,'','sin');
eval {exp $s};
isnt($@,'','exp');
eval {abs $s};
isnt($@,'','abs');
eval {log $s};
isnt($@,'','log');
eval {sqrt $s};
isnt($@,'','sqrt');

#Iteration
eval {<$s>};
isnt($@,'','<>');

#Dereferencing
eval {${$s}};
isnt($@,'','${}');
eval {@{$s}};
isnt($@,'','@{}');
eval {%{$s}};
isnt($@,'','%{}');
eval {&{$s}};
isnt($@,'','&{}');
eval {*{$s}};
isnt($@,'','*{}');

#Conversion
eval {0+$s};
isnt($@,'','0+');


#Special
#Would test this, but not Perl 5.10 and I haven't overridden it
#eval {$s ~~};
#isnt($@,'','~~');

#Ones we expect to succeed -- Ideally none of them would!
#Transcendental
eval {int $s};
is($@,'','int');
#Conversion to bool,string,number
eval {!! $s};
is($@,'','bool');
eval {"$s"};
is($@,'','""');

#Unseals correctly
isnt(unseal($s,$u),$foo);
