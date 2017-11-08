#!/usr/local/env bash

set -e

[ "$TRAVIS_PULL_REQUEST" != "false" ] && exit 0

[ -z "$TRAVIS_TAG" ] && exit 0

brew install mmv tcnksm/ghr/ghr

mkdir -p /tmp/bottles
brew bottle --no-rebuild rstudio-server 2>&1 | tee /tmp/bottles/shasum

mcp 'rstudio-server-*.el_capitan.*.tar.gz' '/tmp/bottles/rstudio-server-#1.el_capitan.#2.tar.gz'
mcp 'rstudio-server-*.el_capitan.*.tar.gz' '/tmp/bottles/rstudio-server-#1.sierra.#2.tar.gz'
mcp 'rstudio-server-*.el_capitan.*.tar.gz' '/tmp/bottles/rstudio-server-#1.high_sierra.#2.tar.gz'

git config user.email "randy.cs.lai@gmail.com"
git config user.email "randy.cs.lai@gmail.com"
git config github.user "randy3k"

ghr -replace "$TRAVIS_TAG" /tmp/bottles
