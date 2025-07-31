#!/bin/bash
# TokyoNight themed keybind reference

# Create temporary file with keybinds
KEYBINDS_FILE="/tmp/keybinds.txt"

cat > "$KEYBINDS_FILE" << 'EOF'
🎮 TOKYONIGHT SWAY KEYBINDS 🎮

💻 SYSTEM & APPLICATIONS
Super + Return         → Launch Terminal (Alacritty)
Super + D             → Application Launcher (nwg-drawer)
Super + Shift + Q     → Kill Focused Window
Super + Shift + E     → Exit Sway
Super + L             → Lock Screen (swaylock)

🪟 WINDOW MANAGEMENT
Super + Arrow Keys    → Move Focus
Super + Shift + Arrow → Move Window
Super + V             → Split Vertical
Super + H             → Split Horizontal
Super + F             → Toggle Fullscreen
Super + Space         → Toggle Floating
Super + Shift + Space → Toggle Focus Floating/Tiling

🏢 WORKSPACES
Super + [1-9]         → Switch to Workspace
Super + Shift + [1-9] → Move Window to Workspace
Super + Tab           → Next Workspace
Super + Shift + Tab   → Previous Workspace

🎮 GAMING & PERFORMANCE
Super + Shift + G     → Toggle GameMode
Super + I             → Toggle Idle Inhibitor

📱 MEDIA & VOLUME
XF86AudioRaiseVolume  → Volume Up
XF86AudioLowerVolume  → Volume Down
XF86AudioMute         → Toggle Mute
XF86AudioPlay         → Play/Pause
XF86AudioNext         → Next Track
XF86AudioPrev         → Previous Track

🔧 UTILITIES
Super + K             → Show This Keybind Reference
Super + Shift + R     → Reload Sway Config
Super + R             → Resize Mode

📂 FILE MANAGEMENT
Super + E             → File Manager (Thunar)

🎨 CUSTOMIZATION
Super + W             → Wallpaper Manager (Azote)
Super + T             → Theme Manager (nwg-look)

💡 PRO TIPS:
- Autotiling is enabled - windows auto-arrange!
- Click waybar modules for quick actions
- Right-click audio icon to mute/unmute
- GameMode indicator shows current status
- Use Super + Mouse to drag floating windows
EOF

# Display using rofi with TokyoNight theme
rofi -dmenu -markup-rows -p "Keybinds Reference" \
    -theme-str 'window {width: 50%; height: 70%;}' \
    -theme-str 'listview {lines: 30;}' \
    -theme-str 'window {background-color: rgba(26, 27, 38, 0.98); border: 2px solid #7aa2f7; border-radius: 10px;}' \
    -theme-str 'inputbar {background-color: #7aa2f7; text-color: #1a1b26; border-radius: 5px; margin: 10px;}' \
    -theme-str 'listview {background-color: transparent; padding: 10px;}' \
    -theme-str 'element {background-color: transparent; text-color: #c0caf5; padding: 2px 10px;}' \
    -theme-str 'element selected {background-color: rgba(122, 162, 247, 0.3); border-radius: 5px;}' \
    -theme-str 'element-text {font: "JetBrainsMono Nerd Font 11";}' \
    < "$KEYBINDS_FILE" > /dev/null

# Clean up
rm "$KEYBINDS_FILE"
