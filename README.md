# rakudo-pkg-canary

[![Build Status](https://travis-ci.org/nxadm/rakudo-pkg-canary.svg?branch=master)](https://travis-ci.org/nxadm/rakudo-pkg-canary)

Test runs for Rakudo pre-releases on several distributions. The Rakudo tar.gz
specified in the .travis.yaml (`RAKUDO_URL`) is rebuilt every 24 hours or
whenever a push happens.

The Docker images used on these runs are automatically update when there is an
update to the base images of Alpine, CentOS, Debian, Fedora, openSUSE or
Ubuntu. Although generally not needed, the run can be customized by creating
the Docker images locally by setting a `LOCAL_BUILD` variable. On normal runs
this repo use pre-created images that are retrieved from the
[DockerHub repository](https://hub.docker.com/r/nxadm/rakudo-pkg-canary). This
is the fastest option. To force an update of the remote DockerHub images,
create a tag in the form of `dh<date>-<revision>`, e.g. `dh20180421-01`.

**This repository is not intended for end users, but as part of the Perl 6 CI
infrastructure. See [rakudo-pkg](https://github.com/nxadm/) for user
packages.**

