#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $DIR/default_vars.sh

mkdir -p build && \
    cd build && \
    cmake .. -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCLANG_CODE_COVERAGE=ON && \
    ninja && \
    bin/ci-tester > /dev/null 2> /dev/null && \
    grcov --llvm . -t coveralls --token $CODECOV_TOKEN --commit-sha `git rev-parse HEAD` > $1/coverage.json
