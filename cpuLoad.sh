#! /bin/bash

# This program is meant to prevent a processor from freezing caused by a too low cpu load
# This program is meant to be ran in a Launcher (xfce) in the system tray

triggerload=5
munberofcpus=1
loadtimecpu=2 # seconds

# the user load + the systemload according to top
usersysload=$(top -b -n 1 | grep "Cpu(s)" | tr ',' '.' | awk '{printf "%0.1f", $2 + $4}')

echo -e "Load:\n$usersysload"

# In case of the default values make sure the tray update period
# is larger then 2 seconds since stress runs for 2 seconds

# Load the computer for $loadtimecpu seconds (default 2)
# if the value of loadhigh is below $usersysload (default 5)
if [[ $(echo $usersysload | cut -d '.' -f 1) -lt $triggerload ]]; then
  stress --quiet --cpu $munberofcpus --timeout $loadtimecpu
fi
