#!/bin/bash
# Gaming mode launcher with optimizations

# Set CPU governor to performance
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Start gamemode
gamemoderun "$@"

# Restore CPU governor after game
echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
