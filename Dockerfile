# common image for everything
FROM fedora:31 as base

RUN useradd -mU builder
RUN dnf -y update


# image for building and creating a basic build environment
FROM base as build-env

RUN dnf -y install \
    cmake \
    clang-libs \
    clang-tools-extra \
    clang-analyzer \
    clang \
    ninja-build \
    libstdc++-static \
    libstdc++-devel \
    glibc-static \
    glibc-devel \
    make

RUN mkdir -p /app && chown builder:builder /app
USER builder
WORKDIR /home/builder

ARG BUILD_TYPE=Debug
ARG CC=clang
ARG CXX=clang++
ARG STATIC_BUILD=ON

COPY . .

CMD ["/bin/bash"]



FROM build-env as build

RUN scripts/build.sh /app




# final image for running as a docker container
FROM scratch as artifact

COPY --from=builder /etc/passwd /etc/passwd

USER 1000

COPY --from=builder --chown=1000:1000 /app /app

CMD ["/app/bin/ci-tester"]
