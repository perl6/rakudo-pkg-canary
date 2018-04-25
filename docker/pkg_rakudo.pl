#!/usr/bin/env perl
use warnings;
use strict;
use feature 'say';

### Variables ###
my $install_root = '/opt/rakudo-pkg';
my $url = $ENV{RAKUDO_URL};

### Check required environment ###
if ($url eq "") {
    say "RAKUDO_URL environment empty!";
    exit 1;
}

### Download & compile Rakudo ###
build() or exit 1;
say "Rakudo was succesfully compiled.";

### Test by installing and running it ###
system($install_root . '/bin/perl6', '-v') == 0 or die($!);

exit 0;

### Functions ###
sub build {
    mkdir 'rakudo' or die($!);
    # Download and unpack
    system('wget', $url, '-O', 'rakudo.tar.gz') == 0 or return 0;
    system('tar', 'xzf', 'rakudo.tar.gz', '-C', 'rakudo', '--strip=1') == 0
        or return 0;
    chdir('rakudo') or die($!);
    # Configure
    my @configure  = (
        'perl', './Configure.pl',
        '--backend=moar', '--gen-moar',
        "--prefix=$install_root"
    );

    system(@configure) == 0 or return 0;
    system('make')     == 0 or return 0;
    system('make', 'test') == 0 or return 0;

    # make install
    system('make', 'install') == 0 or return 0;
    # Clean up
    chdir('/') or die($!);
    return 1;
}
