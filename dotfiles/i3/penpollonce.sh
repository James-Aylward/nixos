#!/usr/bin/env bash
# The purpose of this script is to poll xinput to map pen, eraser and touch
# devices to the laptop screen. This fixes the bug of having these inputs map
# across monitors, which distorts everything and makes it unusable.

xinput map-to-output "CUST0000:00 27C6:0111 Stylus Pen (0)" eDP-1
xinput map-to-output "CUST0000:00 27C6:0111 Stylus Eraser (0)" eDP-1
xinput map-to-output "CUST0000:00 27C6:0111" eDP-1
