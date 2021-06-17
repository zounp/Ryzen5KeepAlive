#! /bin/bash

# This program is meant to be ran in a Launcher (xfce) in the system tray

highload=$(top -b -n1 | grep "Cpu(s)" | tr ',' '.' | awk '{printf "%0.1f", $2 + $4}')

echo -e "Load:\n$highload"

# Make sure the tray update period is 5 seconds or lager since stress runs for 2 seconds

# Load the computer for 2 seconds if the value of loadhigh is below 5
if [[ $(echo $highload | cut -d '.' -f 1) -lt 5 ]]; then
  stress --quiet --cpu 1 --timeout 2
fi
