// SPDX-FileCopyrightText: 2026 Tim Wiederhake
//
// SPDX-License-Identifier: WTFPL

module buttons(
    input wire clk,
    input wire [4:0] nButton,
    output reg [5:0] nLed,
);

always @(posedge clk)
    if (!nButton[0])
        nLed[0] <= 1'b0;
    else if (!nButton[1])
        nLed[0] <= 1'b1;
initial
    nLed[5:1] <= ~0;
endmodule
