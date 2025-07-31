#!/bin/bash
# TokyoNight themed power menu

choice=$(echo -e "🔒 Lock\n💤 Sleep\n🔄 Reboot\n⚡ Shutdown\n🚪 Logout" | \
    rofi -dmenu -i -p "Power Menu" \
    -theme-str 'window {background-color: rgba(26, 27, 38, 0.95); border-color: #7aa2f7;}' \
    -theme-str 'listview {background-color: transparent;}' \
    -theme-str 'element selected {background-color: #7aa2f7; text-color: #1a1b26;}')

case "$choice" in
    "🔒 Lock") swaylock ;;
    "💤 Sleep") systemctl suspend ;;
    "🔄 Reboot") systemctl reboot ;;
    "⚡ Shutdown") systemctl poweroff ;;
    "🚪 Logout") swaymsg exit ;;
esac
