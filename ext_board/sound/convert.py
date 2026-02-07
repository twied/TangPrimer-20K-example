#!/usr/bin/env python3

# SPDX-FileCopyrightText: 2026 Tim Wiederhake
#
# SPDX-License-Identifier: WTFPL

import subprocess

data = subprocess.check_output([
    "ffmpeg",
    "-loglevel", "quiet",           # no log messages
    "-i", "congratulations.ogg",    # input file
    "-ac", "1",                     # 1 audio channel = mono
    "-ar", "8000",                  # sampling frequency
    "-f", "data",                   # output format: raw data
    "-c:a", "pcm_s16le",            # audio codec: PCM signed 16 bit little endian
    "-map", "0",                    # select the audio stream for output
    "-y",                           # overwrite without asking
    "/dev/stdout"                   # output file
])

with open("sound_rom.v", "tw") as f:
    f.write("// SPDX-""FileCopyrightText: 2026 Tim Wiederhake\n");
    f.write("//\n");
    f.write("// SPDX-""License-Identifier: WTFPL\n");
    f.write("\n");
    f.write("module sound_rom(\n");
    f.write("    input wire clk,\n");
    f.write("    input wire [14:0] addr,\n");
    f.write("    output reg [15:0] data\n");
    f.write(");\n");
    f.write("\n");
    f.write("always @(posedge clk)\n");
    f.write("begin\n");
    f.write("    case (addr)\n");

    for i in range(0, len(data) // 2):
        value = data[i + i + 1] * 256 + data[i + i]
        f.write("        14'd{}: data <= 16'd{};\n".format(i, value))

    f.write("        default:   data <= 16'd0;\n");
    f.write("    endcase\n");
    f.write("end\n");
    f.write("\n");
    f.write("endmodule\n");

