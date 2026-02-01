// SPDX-FileCopyrightText: 2026 Tim Wiederhake
//
// SPDX-License-Identifier: WTFPL

module switches(
    output wire [5:0] nLed,
    input wire [5:1] nSwitch
);

assign nLed[0] = ~nSwitch[2];
assign nLed[1] = ~nSwitch[3];
assign nLed[2] = ~(~nSwitch[5] & nSwitch[4]);
assign nLed[3] = ~(nSwitch[5] ^ nSwitch[4]);
assign nLed[4] = ~(nSwitch[5] | nSwitch[4]);
assign nLed[5] = ~(nSwitch[5] & nSwitch[4]);

endmodule
