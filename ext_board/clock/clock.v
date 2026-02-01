// SPDX-FileCopyrightText: 2026 Tim Wiederhake
//
// SPDX-License-Identifier: WTFPL

module clock(
    input wire clk,
    output reg [5:0] nLed
);

parameter ticks_per_second = 27_000_000;

reg [31:0] counter = 0;

always @(posedge clk)
begin
    if (counter >= ticks_per_second / 2)
    begin
        counter <= 0;
        nLed <= ~nLed;
    end
    else
    begin
        counter <= counter + 1;
    end
end
initial
    nLed = 6'b010101;

endmodule

