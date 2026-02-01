<!--
SPDX-FileCopyrightText: 2026 Tim Wiederhake

SPDX-License-Identifier: WTFPL
-->

The ext board comes with five switches located at the right side of the board.
They are labeled "5" to "1" from top to bottom. The example displays the result
of some boolean functions, using the switches as input:

* LED 5: Switch 5 and Switch 4
* LED 4: Switch 5 or Switch 4
* LED 3: Switch 5 xor Switch 4
* LED 2: Switch 5 → Switch4 (= (not Switch 5) and Switch 4)
* LED 1: Switch 3
* LED 0: Switch 2

Note that Switch 1 cannot be used, as it enables / disables the ext board.
