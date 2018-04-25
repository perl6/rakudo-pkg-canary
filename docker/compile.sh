#!/bin/bash -e

PREFIX="/opt/rakudo-pkg"
if [ -z "$RAKUDO_URL" ]; then
    echo "RAKUDO_URL environment empty!"
    exit 1
fi

wget $RAKUDO_URL -O rakudo.tar.gz
tar xvzf rakudo.tar.gz
cd rakudo*
perl /Configure.pl --backend=moar --gen-moar --prefix=$PREFIX
make
make test
make install
/opt/rakudo-pkg/bin/perl6

exit 0;
