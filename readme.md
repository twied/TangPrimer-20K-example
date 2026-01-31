<!--
SPDX-FileCopyrightText: 2026 Tim Wiederhake

SPDX-License-Identifier: WTFPL
-->

This is a set of alternative examples for the Sipeed Tang Primer 20K FPGA and
its extension board. The main goal of this repository is to provide beginner
friendly examples that can be used with only Open Source tools under Linux.

See also the
[official repository](https://github.com/sipeed/TangPrimer-20K-example/), and
[this repository](https://github.com/mikewolak/tangprimer20k-oss-examples)
adding the required pieces to make the examples in the official repository work
with Open Source tools.

More information about the Tang Primer 20k can be found on the [official
wiki](https://wiki.sipeed.com/hardware/en/tang/tang-primer-20k/primer-20k.html)
and the [GowinFPGA subreddit](https://www.reddit.com/r/GowinFPGA/).

# License

All code in this repository is licensed under the terms of the
[WTFPL](LICENSES/WTFPL.txt).

# Bugs and issues

I am still learning and I make mistakes. If you find anything wrong with the
code in this repository or have suggestions for improvement, please do not
hesitate to
[open a ticket](https://github.com/twied/TangPrimer-20K-example/issues).

# Setup

I found that the software shipped in Linux distros (e.g. Debian as of January
2026) is outdated and does not work. It is necessary to build some tools
directly from source. To ease that process, check out the
[Docker container](docker).
