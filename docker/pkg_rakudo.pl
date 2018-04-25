#!/usr/bin/env perl
use warnings;
use strict;
use feature 'say';

### Variables ###
my $install_root = '/opt/rakudo-pkg';
my $url = $ENV{RAKUDO_URL};
if ($url eq "") {
    say "RAKUDO_URL environment empty!";
    exit 1;
}

### Download & compile Rakudo ###
mkdir '/root/rakudo' or die($!);
system('wget', $url, '-O', 'rakudo.tar.gz') == 0 or return 0;
system('tar', 'xzf', 'rakudo.tar.gz', '-C', 'rakudo', '--strip=1') == 0
    or return 0;
chdir('rakudo') or die($!);
my @configure  =
    ( 'perl', './Configure.pl', '--backend=moar', '--gen-moar');
system(@configure)        == 0 or return 0;
system('make')            == 0 or return 0;
system('make', 'test')    == 0 or return 0;
system('make', 'install') == 0 or return 0;

### Test by installing and running it ###
system('/root/rakudo/install/bin/perl6', '-v') == 0 or die($!);

exit 0;
