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

# Components on the ext board

* Make sure that switch 1 on the ext board is in the `on` (down) position.
  If it is not, flashing will hang indefinitely.

* The `run.sh` scripts in the individual directories use some environment
  variables to find the required tools. They default to the usual program
  names, so that a bare metal installation should "just work":

    * `tang20k_yosys` (default: `yosys`),

    * `tang20k_pnr` (default: `nextpnr-himbaechel`),

    * `tang20k_pack` (default: `gowin_pack`), and

    * `tang20k_loader` (default: `openFPGALoader`).

If you created a docker image as described above and installed a "tang20k"
wrapper script, set the variables like so:

```sh
export tang20k_yosys="tang20k yosys"
export tang20k_pnr="tang20k nextpnr-himbaechel"
export tang20k_pack="tang20k gowin_pack"
```

To make these changes persistent, you may want to put these lines in your
`${HOME}/.bashrc` file.

## LEDs

The ext board comes with six orange LEDS located at the right side of the
board. They are labeled "5" to "0" from top to bottom. The
[example](ext_board/leds) displays a simple static pattern.

## Clock

A simple [example](ext_board/clock) that flashes the LEDs once per second, in
an alternating pattern.

## Switches

This [example](ext_board/switches) demonstrates how to read the status of the
5 switches located at the right side of the board. The LEDs display the result
of some boolean functions.

## Buttons

This [example](ext_board/buttons) shows how to read the status of the 5 buttons
located at the left side of the board. Pushing S0 will turn LED 0 on, pushing
S1 will turn the LED off.

## RGB LED

This [example](ext_board/rgb_led) shows how to drive the RGB LED on the top
left of the board by turning it yellow at medium intensity.
