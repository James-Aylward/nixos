#!/bin/sh

xfconf-query -c xfce4-panel -p /panels -t int -s 1 -a
xfce4-panel -r
