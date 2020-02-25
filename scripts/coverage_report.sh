#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $DIR/default_vars.sh

mkdir -p build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DCLANG_CODE_COVERAGE=ON && \
    make && \
    bin/ci-tester > /dev/null 2> /dev/null && \
    grcov --llvm . -t coveralls+ --token unused --commit-sha unused > $1/coverage.json
