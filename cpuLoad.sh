#! /bin/bash

# Introduction
# ------------
# This program is meant to prevent a processor from freezing caused by a too low cpu load

# Manual
# ------
# This program is meant to be ran in a generic monitor in a xfce panel.
# In case of the default values make sure the generic monitor update period
# is larger then 2 seconds since stress runs for 2 seconds.


triggerload=5
munberofcpus=1
loadtimecpu=2 # seconds.

# the user load + the systemload according to top.
usersysload=$(top -b -n 1 | grep 'Cpu(s)' | tr ',' '.' | awk '{printf "%0.1f", $2 + $4}')

echo -e "Load:\\n$usersysload"

# Load the computer for $loadtimecpu seconds (default 2).
# if the value of loadhigh is below $usersysload (default 5).
if [[ $(cut -d '.' -f 1 <<< "$usersysload") -lt $triggerload ]]; then
  stress --quiet --cpu $munberofcpus --timeout $loadtimecpu
fi
