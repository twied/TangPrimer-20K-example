// SPDX-FileCopyrightText: 2026 Tim Wiederhake
//
// SPDX-License-Identifier: WTFPL

module rgb_led(
    input wire clk,
    output reg rgb
);

parameter STATE_RESET       = 0;
parameter STATE_HIGH        = 1;
parameter STATE_LOW         = 2;
integer state               = STATE_RESET;

parameter TICKS_RESET       = 9000;
parameter TICKS_BIT_SHORT   = 8;
parameter TICKS_BIT_LONG    = 32;
integer tick                = 0;

parameter BITS              = 24;
reg [0:(BITS-1)] data       = 24'h808000;
integer bit                 = 0;

always @(posedge clk)
begin
    case (state)
    STATE_RESET:
    begin
        rgb <= 0;
        if (tick < TICKS_RESET)
            tick <= tick + 1;
        else
        begin
            state <= STATE_HIGH;
            tick <= 1;
            bit <= 0;
        end
    end

    STATE_HIGH:
    begin
        rgb <= 1;
        if (tick < (data[bit] ? TICKS_BIT_LONG : TICKS_BIT_SHORT))
            tick <= tick + 1;
        else
        begin
            state <= STATE_LOW;
            tick <= 1;
        end
    end

    STATE_LOW:
    begin
        rgb <= 0;
        if (tick < (data[bit] ? TICKS_BIT_SHORT : TICKS_BIT_LONG))
            tick <= tick + 1;
        else
        begin
            if (bit < (BITS - 1))
                state <= STATE_HIGH;
            else
                state <= STATE_RESET;
            tick <= 1;
            bit <= bit + 1;
        end
    end

    default:
    begin
        rgb <= 0;
        state <= STATE_RESET;
        tick <= 1;
    end
    endcase
end

endmodule
