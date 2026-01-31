#!/usr/bin/env docker build -t tang20k -v ${PWD}:/src:rw .

# SPDX-FileCopyrightText: 2026 Tim Wiederhake
#
# SPDX-License-Identifier: WTFPL

FROM ubuntu:24.04

COPY install.sh /install.sh

RUN \
    touch /.dockerenv && \
    mkdir -p /src && \
    cd /src && \
    bash /install.sh

WORKDIR /work
