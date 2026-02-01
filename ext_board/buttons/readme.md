<!--
SPDX-FileCopyrightText: 2026 Tim Wiederhake

SPDX-License-Identifier: WTFPL
-->

The ext board comes with five push buttons located at the left side of the
board. They are labeled "S0" to "S4" from top to bottom. The example implements
a simple RS-Flip-Flop: Pressing `S0` will turn the LEDs on, pressing `S1` will
turn them off again.

Note that the buttons are **active low**, i.e. reading `0` means the button is
**pressed**, reading `1` means the button is **released**.

The simplest version of an RS-Flip-Flop does not use or need a clock (then
often called an RS latch instead). Unclocked latches are prone to timing issues
and race conditions and are rarely used in real-world applications. In fact,
the Tang Primer 20k does not even support unclocked latches. Trying to
synthesize:

```verilog
module buttons(
    input wire [4:0] nButton,
    output reg [5:0] nLed,
);

always @(*)
    if (nButton[0])
        nLed[0] = 1'b0;
    else if (nButton[1])
        nLed[0] = 1'b1;
initial
    nLed[5:1] = ~0;

endmodule
```

results in:

```
ERROR: FF buttons.$auto$ff.cc:337:slice$656 (type $_DLATCH_N_) cannot be legalized: D latches are not supported
```
