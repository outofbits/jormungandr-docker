#!/bin/sh
set -e
set -x

source ~/.cargo/env

if [ ! -z "$REV_HASH" ]; then
	cargo install --git $GIT_REPO --branch $GIT_BRANCH --rev $REV_HASH --target x86_64-unknown-linux-gnu --force jormungandr
else
	cargo install --git $GIT_REPO --branch $GIT_BRANCH --target x86_64-unknown-linux-gnu --force jormungandr
fi

mv ~/.cargo/bin/jormungandr /binaries


