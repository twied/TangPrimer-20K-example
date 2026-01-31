#!/bin/bash

# SPDX-FileCopyrightText: 2026 Tim Wiederhake
#
# SPDX-License-Identifier: WTFPL

set -e -u -x

# noninteractive installs for docker images
if [ -f /.dockerenv ]
then
    export DEBIAN_FRONTEND="noninteractive"
fi

# build dependencies for yosys and nextpnr
apt update
apt install -y \
    bison \
    build-essential \
    clang \
    clang-format \
    cmake \
    flex \
    gawk \
    git \
    graphviz \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-iostreams-dev \
    libboost-program-options-dev \
    libboost-python-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libeigen3-dev \
    libffi-dev \
    libfl-dev \
    libreadline-dev \
    lld \
    make \
    pkg-config \
    python3 \
    python3-dev \
    python3-full \
    python3-pip \
    tcl-dev \
    xdot \
    zlib1g-dev

# try to minimize docker image size
if [ -f /.dockerenv ]
then
    apt clean
    rm -rf /var/lib/apt/lists/*
fi

# a reasonably recent version of Apycula can be aquired from pip, no need to
# compile it locally
pip install --break-system-packages --user apycula

if [ -f /.dockerenv ]
then
    # in a docker container it is easier to just create a symlink
    ln "${HOME}/.local/bin/gowin_pack" "/usr/local/bin/gowin_pack"
else
    # append default installation target directory to PATH
    echo 'PATH="${PATH}:${HOME}/.local/bin"' >> "${HOME}/.bashrc"
fi

# fetch yosys sources
if [ ! -d "yosys" ]
then
    git clone "https://github.com/YosysHQ/yosys.git"
    # known good version:
    # git checkout 8f6c4d40e4b3cb062ff4bfc0647e5ad4c879e2a2
fi

# build and install yosys
pushd "yosys"
    git submodule update --init --recursive
    make -j$(nproc)
    make install
popd

# fetch nextpnr sources
if [ ! -d "nextpnr" ]
then
    git clone "https://github.com/YosysHQ/nextpnr.git"
    # known good version:
    # git checkout 8c6278170be1df71a6224110f0b8d5997740fc1e
fi

# build and install nextpnr
pushd "nextpnr"
    git submodule update --init --recursive
    mkdir -p "build"
    pushd "build"
        cmake ".." -DARCH="himbaechel" -DHIMBAECHEL_UARCH="gowin"
        make -j$(nproc)
        make install
    popd
popd

# create a working directory in docker images
if [ -f /.dockerenv ]
then
    mkdir -p "/work"
fi
