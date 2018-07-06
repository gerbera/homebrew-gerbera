# Homebrew Tap for Gerbera Media Server

[![Build Status](https://travis-ci.org/gerbera/homebrew-gerbera.svg?branch=master)](https://travis-ci.org/gerbera/homebrew-gerbera)

This repository holds the relevant homebrew formulas to install the Gerbera Media Server.

## Using this Homebrew Tap

Use the documentation to establish a new Tap:

[https://docs.brew.sh/Taps](https://docs.brew.sh/Taps)

### Add the Gerbera Tap
```
$ brew tap gerbera/homebrew-gerbera
```

Check that you have the `gerbera/gerbera` tap.

```
$ brew tap
==> Auto-updated Homebrew!
caskformula/caskformula
gerbera/gerbera
homebrew/cask
homebrew/core
```

## Install Gerbera

```
$ brew install gerbera

==> Installing gerbera from gerbera/gerbera
==> Installing dependencies for gerbera/gerbera/gerbera: duktape, gerbera/gerbera/libupnp
==> Installing gerbera/gerbera/gerbera dependency: duktape
==> Downloading http://duktape.org/duktape-2.2.1.tar.xz
==> make -f Makefile.sharedlibrary
==> make -f Makefile.sharedlibrary install
🍺  /usr/local/Cellar/duktape/2.2.1: 13 files, 789.6KB, built in 6 seconds
==> Installing gerbera/gerbera/gerbera dependency: gerbera/gerbera/libupnp
==> Downloading https://homebrew.bintray.com/bottles-gerbera/libupnp-1.8.3.high_sierra.bottle.tar.gz
curl: (22) The requested URL returned error: 404 Not Found
Error: Failed to download resource "libupnp"
Download failed: https://homebrew.bintray.com/bottles-gerbera/libupnp-1.8.3.high_sierra.bottle.tar.gz
Warning: Bottle installation failed: building from source.
==> Downloading https://downloads.sourceforge.net/project/pupnp/pupnp/libUPnP%201.8.3/libupnp-1.8.3.tar.bz2
==> ./configure --prefix=/usr/local/Cellar/libupnp/1.8.3 --enable-ipv6 --enable-reuseaddr
==> make install
🍺  /usr/local/Cellar/libupnp/1.8.3: 42 files, 1MB, built in 24 seconds
==> Installing gerbera/gerbera/gerbera
==> Downloading https://github.com/gerbera/gerbera/archive/v1.2.0.tar.gz
==> cmake .. -DCMAKE_C_FLAGS_RELEASE=-DNDEBUG -DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG -DCMAKE_INSTALL_PREFIX=/usr/local/Cellar/gerbera/1.2.0 -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND
==> make install
🍺  /usr/local/Cellar/gerbera/1.2.0: 150 files, 7.9MB, built in 22 seconds
```
