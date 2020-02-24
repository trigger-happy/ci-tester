#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $DIR/default_vars.sh

mkdir -p build && \
    cd build && \
    cmake .. -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCLANG_CODE_COVERAGE=ON && \
    ninja && \
    bin/ci-tester > /dev/null 2> /dev/null && \
    llvm-profdata merge -sparse default.profraw -o default.profdata && \
    llvm-cov show bin/ci-tester -instr-profile=default.profdata > $1/coverage.txt
