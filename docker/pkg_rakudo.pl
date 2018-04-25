#!/usr/bin/env perl
use warnings;
use strict;
use feature 'say';

### Variables ###
my $install_root = '/opt/rakudo-pkg';

### Check required environment ###
check_env( 'RAKUDO_URL') or exit 1;
my $url = $ENV{RAKUDO_URL};

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
    unlink('rakudo.tar.gz') or warn($!);
    chdir('rakudo') or die($!);
    # Configure
    my @configure  = ('perl', './Configure.pl', "--prefix=$install_root",
                      '--backend=moar', '--gen-moar');

    system(@configure) == 0 or return 0;
    system('make')     == 0 or return 0;
    system('make', 'test') == 0 or return 0;

    # make install
    system('make', 'install') == 0 or return 0;
    # Clean up
    chdir('/') or die($!);
    remove_tree('rakudo') or warn($!);
    return 1;
}

sub check_env {
    my @keys = @_;
    my $error;
    for my $key (@keys) {
        if (! exists $ENV{$key}) {
            say STDERR "Environment variable $key not set.";
            $error = 1;
        }
    }
    return 0 if $error;
    return 1;
}
