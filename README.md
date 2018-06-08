# Homebrew Tap for Gerbera Media Server

This repository holds the relevant homebrew formulas to install the Gerbera Media Server.

## Using this Homebrew Tap

Use the documentation to establish a new Tap:

[https://docs.brew.sh/Taps](https://docs.brew.sh/Taps)

### Example Command

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

## Install Gerbera Dependencies

### Duktape

```
$ brew install duktape

==> Installing duktape from gerbera/gerbera
==> Downloading http://duktape.org/duktape-2.2.1.tar.xz
Already downloaded: /Library/Caches/Homebrew/duktape-2.2.1.tar.xz
==> make -f Makefile.sharedlibrary
==> make -f Makefile.sharedlibrary install
🍺  /usr/local/Cellar/duktape/2.2.1: 13 files, 789.6KB, built in 6 seconds
```

### Libupnp

```
$ brew install libupnp
```

This installs the 1.6.25 version, but we will later upgrade to 1.8.3

```
$ brew upgrade --build-from-source gerbera/gerbera/libupnp

==> Installing libupnp from gerbera/gerbera
==> Downloading https://downloads.sourceforge.net/project/pupnp/pupnp/libUPnP%201.8.3/libupnp-1.8.3.tar.bz2
Already downloaded: /Library/Caches/Homebrew/libupnp-1.8.3.tar.bz2
==> ./configure --prefix=/usr/local/Cellar/libupnp/1.8.3 --enable-ipv6 --enable-reuseaddr
==> make install
🍺  /usr/local/Cellar/libupnp/1.8.3: 42 files, 1MB, built in 23 seconds
```

### Gerbera

```
$ brew install gerbera

==> Installing gerbera from gerbera/gerbera
==> Downloading https://github.com/gerbera/gerbera/archive/v1.2.0.tar.gz
Already downloaded: /Library/Caches/Homebrew/gerbera-1.2.0.tar.gz
==> cmake .. -DCMAKE_C_FLAGS_RELEASE=-DNDEBUG -DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG -DCMAKE_INSTALL_PREFIX=/usr/local/Cellar/gerbera/1.2.0 -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND
==> make install
🍺  /usr/local/Cellar/gerbera/1.2.0: 150 files, 7.9MB, built in 23 seconds
```
