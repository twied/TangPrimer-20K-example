#!/bin/sh

# SPDX-FileCopyrightText: 2026 Tim Wiederhake
#
# SPDX-License-Identifier: WTFPL

set -e -x -u

module="clock"

sources="clock.v"

${tang20k_yosys:-yosys} \
    --quiet \
    --commands "read_verilog ${sources};" \
    --commands "synth_gowin -top ${module} -family gw2a -json ${module}.json"

${tang20k_pnr:-nextpnr-himbaechel} \
    --quiet \
    --json "${module}.json" \
    --write "${module}.pnr.json" \
    --device "GW2A-LV18PG256C8/I7" \
    --vopt family="GW2A-18" \
    --vopt cst="constraints.cst"

${tang20k_pack:-gowin_pack} \
    --device "GW2A-18" \
    --output "${module}.fs" \
    --cst "pinout.cst" \
    "${module}.pnr.json"

${tang20k_loader:-openFPGALoader} \
    "${module}.fs" \
    --quiet \
    --board "tangprimer20k" \
    #--write-flash
