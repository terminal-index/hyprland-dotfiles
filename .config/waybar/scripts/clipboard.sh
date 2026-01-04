#!/bin/bash
cliphist list | rofi -dmenu --width 700 --height 400 | cliphist decode | wl-copy
