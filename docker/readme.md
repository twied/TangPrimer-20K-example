<!--
SPDX-FileCopyrightText: 2026 Tim Wiederhake

SPDX-License-Identifier: WTFPL
-->

# Why not use software from your distro?

I found that the software versions in some Linux distributions are outdated and
unable to produce working images for the FPGA.
[Combinational logic](https://en.wikipedia.org/wiki/Combinational_logic) would
work just fine, but the inclusion of any sort of flip-flop, state or memory
to create [sequential logic](https://en.wikipedia.org/wiki/Sequential_logic)
results in a completely frozen and unresponsive FPGA.

## What is broken

For reference, the **not** working software packages in Debian, as of
January 2026, were:

* nextpnr-gowin-qt `0.7-1+b2`
* yosys `0.52-2`
* python3-apycula `0.17+dfsg1-1`

## What does work

* openFPGALoader `0.13.1-1`

# Using upstream software

The solution is to grab nextpnr, yosys and apycula directly from upstream and
compile and install it locally.

Option 1 is to do that directly on the machine you are working on. I do not
like this approach as I prefer to keep my computer managed by the package
manager and installing random binaries into my system interferes with that.

Option 2: Set up a VM, install the software there, and use e.g. ssh to interact
with the VM. This option offers the maximum separation but requires some setup
to transfer files back and forth comfortably.

Option 3: Put everything in a docker container. I believe this solution offers
the best tradeoff between conveniance and isolation.

To support all three options, I have collected all necessary steps in an
[installation script](install.sh).

# Installation

## Bare metal

If you are using a Debian, Ubuntu or derivative, running `install.sh` should
"just work". Note that the script will create two rather sizeable directories,
`yosys` and `nextpnr`, containing the sources.

## Virtual machine

Transfer the install script to your VM and execute it, e.g.:
```sh
$ curl https://raw.githubusercontent.com/twied/TangPrimer-20K-example/refs/heads/master/docker/install.sh | bash
```

## Docker

Use the docker file in this directory:

```sh
$ docker build . -t tang20k

# alternative, to not store the source code inside the container:
$ docker build . -t tang20k -v ${PWD}:/src:rw
```

On a side note: If using podman instead of docker and everything is incredibly
slow, check that you are using `overlay`, not `vfs` as a file system driver.
Check by running `podman info --debug | grep graphDriverName`.

Splitting the docker image into a "builder" and a "runner" image is left as
an excercise for the reader ;-).

# Usage

If installed on bare metal or in a VM, the commands should be directly
available:

```sh
$ yosys --version
Yosys 0.61+80 (git sha1 8f6c4d40e, g++ 13.3.0-6ubuntu2~24.04 -fPIC -O3)
```

If using docker, I recommend using a [wrapper script](tang20k) or creating
[aliases](https://www.man7.org/linux/man-pages//man1/bash.1.html#ALIASES) for
ease of use:

```sh
$ cp tang20k ~/.local/bin/
$ tang20k yosys --version
Yosys 0.61+80 (git sha1 8f6c4d40e, g++ 13.3.0-6ubuntu2~24.04 -fPIC -O3)

$ alias tang20k-yosys="docker run -it --rm -v .:/work tang20k yosys"
$ tang20k-yosys --version
Yosys 0.61+80 (git sha1 8f6c4d40e, g++ 13.3.0-6ubuntu2~24.04 -fPIC -O3)
```
