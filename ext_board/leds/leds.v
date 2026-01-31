// SPDX-FileCopyrightText: 2026 Tim Wiederhake
//
// SPDX-License-Identifier: WTFPL

module leds(
    output wire [5:0] nLed
);

assign nLed = {
    1'b0,
    1'b1,
    1'b0,
    1'b0,
    1'b1,
    1'b1
};

endmodule

