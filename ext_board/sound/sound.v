// SPDX-FileCopyrightText: 2026 Tim Wiederhake
//
// SPDX-License-Identifier: WTFPL

module sound(
    input wire clk,
    output wire pt8211_enable,
    output reg pt8211_ws,
    output reg pt8211_bck,
    output reg pt8211_din
);

parameter AUDIO_FREQ        = 8_000;
parameter AUDIO_SAMPLES     = 10_371;
parameter TICKS_PER_SAMPLE  = 27_000_000 / AUDIO_FREQ;

sound_rom sound_data(
    .clk(clk),
    .addr(sample),
    .data(data)
);

integer ticks_sample = 0;
integer ticks_bit = 0;
reg [14:0] sample = 0;
reg [15:0] buffer = 0;
wire [15:0] data;

assign pt8211_enable = 1;

// advance to next sample 8000 times per second
always @(posedge clk)
begin
    if (ticks_sample < TICKS_PER_SAMPLE)
    begin
        ticks_sample <= ticks_sample + 1;
    end
    else
    begin
        ticks_sample <= 0;
        sample <= sample < AUDIO_SAMPLES ? sample + 1 : 0;
    end
end

always @(posedge clk)
begin
    // transfer 16 bits using 2 ticks per bit
    if (ticks_bit < 31)
    begin
        ticks_bit <= ticks_bit + 1;
    end
    else
    begin
        ticks_bit <= 0;
        
        // update sample only between updates
        buffer <= data;

        // switch back and forth between right and left channel, using the same
        // (mono) audio data for both channels
        pt8211_ws <= !pt8211_ws;
    end

    // data is read into the 8211 on a rising edge of BCK. tick 1 is used to
    // set data and pull BCK low, then tick 2 raises BCK to transmit bit.
    // reverse bit order, 8211 expects MSB first.
    pt8211_bck <= ticks_bit[0];
    pt8211_din <= buffer[15 - (ticks_bit / 2)];
end

endmodule
