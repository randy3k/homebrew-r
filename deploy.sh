#!/usr/local/env bash

set -e

[ "$TRAVIS_PULL_REQUEST" != "false" ] && exit 0

[ -z "$TRAVIS_TAG" ] && exit 0

brew install mmv tcnksm/ghr/ghr

cd /tmp/bottles
mcp '*.tar.gz' '/tmp/bottles/#1.tar.gz'

git config user.email "randy.cs.lai@gmail.com"
git config user.email "randy.cs.lai@gmail.com"
git config github.user "randy3k"

ghr -replace "$TRAVIS_TAG" /tmp/bottles
