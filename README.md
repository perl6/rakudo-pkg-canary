# rakudo-pkg-canary

[![Build Status](https://travis-ci.org/nxadm/rakudo-pkg-canary.svg?branch=master)](https://travis-ci.org/nxadm/rakudo-pkg-canary)

Test for Rakudo pre-releases. The Rakudo tar.gz specified in
the .travis.yaml (`RAKUDO_URL`) is rebuilt every 24 hours or whenever a
push happens. A `LOCAL_BUILD` variable can be used to build the docker images
instead pulling the from the DockerHub repository (the faster default).

This repository is not intended for end users, but as part of the Perl 6 CI
infrastructure. See [rakudo-pkg](https://github.com/nxadm/) for user packages.

