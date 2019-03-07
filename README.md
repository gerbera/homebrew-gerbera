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

## Install and lauch Gerbera

```
brew install gerbera
mkdir ~/.config/gerbera
gerbera --create-config | sed 's/accounts enabled="no"/accounts enable="yes"/' > ~/.config/gerbera/config.xml
gerbera &
sleep 5 ; open -a Safari http://0.0.0.0:49152/
```

Use gerbera/gerbera to connect.
