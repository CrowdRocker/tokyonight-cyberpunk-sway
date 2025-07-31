#!/bin/bash
# Enhanced gamemode toggle with visual feedback

if pgrep -x "gamemoded" > /dev/null; then
    # GameMode is running, disable it
    pkill gamemoded
    notify-send "🎮 GameMode" "Disabled - System optimized for desktop use" -t 3000

    # Optional: Reset CPU governor to powersave/ondemand
    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
else
    # GameMode is not running, enable it
    gamemoded &
    notify-send "🎮 GameMode" "Enabled - System optimized for gaming" -t 3000

    # Optional: Set CPU governor to performance
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
fi
