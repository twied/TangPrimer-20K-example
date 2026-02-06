<!--
SPDX-FileCopyrightText: 2026 Tim Wiederhake

SPDX-License-Identifier: WTFPL
-->

The ext board comes with an WS2812 RGB LED located in the top right corner. The
LED has four pins: `gnd`, `vcc`, `data_in` and `data_out`. The LED operates
using a one-bit-protocol, and supports chaining by connecting `data_in` of the
first LED to your controller and `data_in` of every further LED to `data_out`
of the LED preceeding it. Every LED strips off the first 24 bits of a data
frame, interpreting it as three times eight bit of R, G, B data each.

A data frame is thus a multiple of 24 bits of data followed by a `reset`
signal. Since there is only one LED we can choose "nice" values for the signal
timing, as we do not have to optimize for performance:

* to send a RESET signal:
    * hold the data line low for more than 300 us, or 8100 clock ticks of our
      27 MHz clock; we will use 9000 ticks
* to send a '0' bit:
    * we have to hold the data line high for 220 ns to 380 ns, or 5.94 to
      10.26 ticks; we will use 8.
    * then, hold the data line low for 750 ns to 1600 ns, or 20.25 to 43.20
      ticks; we will use 32.
* to send a '1' bit:
    * we have to hold the data line high for 750 ns to 1600 ns, or 20.25 to
      43.20 ticks; we will use 32.
    * then, hold the data line low for 220 ns to 420 (not 380!) ns, or 5.94
      to 11.34 ticks; we will use 8.
* Sending a bit, i.e. holding the data line high plus holding the line low,
  must together be in the range 650 ns to 1850 ns, or 17.55 to 49.95 ticks.
  32 + 8 = 40 fulfills that requirement.

## Links

* [Data sheet](https://www.ledyilighting.com/wp-content/uploads/2025/02/WS2812B-datasheet.pdf)
