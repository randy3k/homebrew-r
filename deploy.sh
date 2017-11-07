#!/usr/local/env bash

set -e

[ "$TRAVIS_PULL_REQUEST" != "false" ] && exit 0

mkdir -p /tmp/bottles
brew bottle --no-rebuild rstudio-server 2>&1 | tee /tmp/bottles/shasum

mcp 'rstudio-server-*.el_capitan.*.tar.gz' '/tmp/bottles/rstudio-server-#1.el_capitan.#2.tar.gz'
mcp 'rstudio-server-*.el_capitan.*.tar.gz' '/tmp/bottles/rstudio-server-#1.sierra.#2.tar.gz'
mcp 'rstudio-server-*.el_capitan.*.tar.gz' '/tmp/bottles/rstudio-server-#1.high_sierra.#2.tar.gz'

git config user.email "randy.cs.lai@gmail.com"
git config user.name "Randy Lai"

if [ -n "$TRAVIS_TAG" ]; then
    ghr -replace "$TRAVIS_TAG" /tmp/bottles
else if [ "$TRAVIS_BRANCH" == "master" ]; then
    ghr -replace -recreate "$RSBUILD" /tmp/bottles
fi
