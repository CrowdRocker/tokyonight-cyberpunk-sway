# TokyoNight Cyberpunk SwayFX Setup Guide
*Arch Linux | AMD RX 580 Optimized | i5-4430*

## 🎨 Theme Overview
- **Look**: TokyoNight cyberpunk aesthetic with neon accents
- **Colors**: Deep purples, electric blues, neon pinks/greens
- **Effects**: SwayFX blur, rounded corners, shadows
- **Performance**: AMD-optimized gaming stack

## 📦 Core Packages Installation

### Essential System Packages
```bash
# Core Wayland/Sway components
sudo pacman -S sway swayidle swaylock
# Install SwayFX (AUR)
yay -S swayfx-git

# Display and session management
sudo pacman -S sddm qt5-graphicaleffects qt5-quickcontrols2
yay -S sddm-sugar-candy-git

# Audio stack
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pavucontrol

# File management and utilities
sudo pacman -S thunar thunar-volman gvfs
sudo pacman -S azote # Wallpaper manager
```

### Widgets and Interface
```bash
# Waybar and widgets
sudo pacman -S waybar
yay -S eww-git

# Application launchers and docks
yay -S nwg-drawer nwg-dock nwg-look
sudo pacman -S rofi-wayland

# Terminal and shell
sudo pacman -S alacritty xfce4-terminal
sudo pacman -S starship # Shell prompt
```

### Gaming and Performance Stack
```bash
# AMD drivers and Vulkan
sudo pacman -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
sudo pacman -S amdvlk lib32-amdvlk # Optional: AMD's official Vulkan driver

# Gaming utilities
sudo pacman -S steam lutris gamemode gamescope
yay -S heroic-games-launcher-bin
yay -S gamemode-toggle-git

# Performance tools
sudo pacman -S zram-generator
yay -S fsync-git # If using custom kernel with fsync patches
sudo pacman -S python-i3ipc # For autotiling
yay -S autotiling
```

## ⚙️ Configuration Files

### SwayFX Configuration (~/.config/sway/config)
```bash
# TokyoNight variables
set $bg #1a1b26
set $fg #c0caf5
set $br #565f89
set $in #414868
set $ac #7aa2f7
set $ur #f7768e

# SwayFX specific settings
blur enable
blur_xray disable
blur_passes 2
blur_radius 3
corner_radius 10
shadows enable
shadow_blur_radius 20
shadow_color #000000AA

# Gaps and borders
gaps inner 8
gaps outer 4
default_border pixel 2
default_floating_border pixel 2

# Window colors
client.focused $ac $ac $fg $ac $ac
client.focused_inactive $br $br $fg $br $br
client.unfocused $bg $bg $fg $bg $bg
client.urgent $ur $ur $fg $ur $ur

# Autostart applications
exec waybar
exec azote --restore
exec swaybg -i ~/.config/wallpapers/tokyonight-city.jpg
exec_always nwg-dock
exec autotiling

# Key bindings
bindsym $mod+Shift+g exec gamemode-toggle
bindsym $mod+k exec ~/.config/scripts/keybinds.sh
```

### Waybar Configuration (~/.config/waybar/config)
```json
{
    "layer": "top",
    "position": "top",
    "height": 40,
    "spacing": 8,
    "modules-left": ["custom/arch", "sway/workspaces", "sway/mode"],
    "modules-center": ["clock", "custom/weather"],
    "modules-right": [
        "custom/pacman",
        "temperature",
        "cpu",
        "memory",
        "disk",
        "custom/gamemode",
        "pulseaudio",
        "bluetooth",
        "network",
        "idle_inhibitor",
        "custom/keybinds",
        "custom/power"
    ],
    
    "custom/arch": {
        "format": "  ",
        "tooltip": false,
        "on-click": "nwg-drawer"
    },
    
    "sway/workspaces": {
        "disable-scroll": true,
        "format": "{icon}",
        "format-icons": {
            "1": "",
            "2": "",
            "3": "",
            "4": "",
            "5": "󰊴",
            "urgent": "",
            "focused": "",
            "default": ""
        }
    },
    
    "clock": {
        "format": "󰅐 {:%H:%M}",
        "format-alt": "󰃭 {:%Y-%m-%d}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
    },
    
    "cpu": {
        "format": " {usage}%",
        "on-click": "alacritty -e btop"
    },
    
    "memory": {
        "format": " {used:0.1f}G",
        "on-click": "alacritty -e btop"
    },
    
    "temperature": {
        "critical-threshold": 80,
        "format": "{icon} {temperatureC}°C",
        "format-icons": ["", "", "", "", ""]
    },
    
    "custom/pacman": {
        "format": "󰏔 {}",
        "interval": 3600,
        "exec": "checkupdates | wc -l",
        "on-click": "alacritty -e sudo pacman -Syu"
    },
    
    "custom/gamemode": {
        "format": "{}",
        "interval": 5,
        "exec": "if pgrep -x gamemoded > /dev/null; then echo '🎮 ON'; else echo '🎮 OFF'; fi",
        "on-click": "gamemode-toggle",
        "tooltip-format": "GameMode Status"
    },
    
    "custom/keybinds": {
        "format": "󰌌",
        "tooltip": false,
        "on-click": "~/.config/scripts/keybinds.sh"
    },
    
    "network": {
        "format-wifi": "󰖩 {essid}",
        "format-ethernet": "󰈀 Connected",
        "format-linked": "󰈀 {ifname} (No IP)",
        "format-disconnected": "󰖪 Disconnected",
        "format-alt": "{ifname}: {ipaddr}/{cidr}",
        "tooltip-format": "{ifname} via {gwaddr}",
        "on-click-right": "nm-connection-editor"
    },
    
    "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
            "activated": "󰅶",
            "deactivated": "󰾪"
        },
        "tooltip-format-activated": "Idle inhibitor: {status}",
        "tooltip-format-deactivated": "Idle inhibitor: {status}"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-bluetooth": "{icon}󰂯 {volume}%",
        "format-bluetooth-muted": "󰝟󰂯",
        "format-muted": "󰝟",
        "format-source": "󰍬 {volume}%",
        "format-source-muted": "󰍭",
        "format-icons": {
            "headphone": "󰋋",
            "hands-free": "󱡒",
            "headset": "󰋎",
            "phone": "󰏲",
            "portable": "󰦧",
            "car": "󰄋",
            "default": ["󰕿", "󰖀", "󰕾"]
        },
        "on-click": "pavucontrol",
        "on-click-right": "pactl set-sink-mute @DEFAULT_SINK@ toggle",
        "scroll-step": 5
    },
    
    "custom/power": {
        "format": "󰐥",
        "tooltip": false,
        "on-click": "~/.config/scripts/power-menu.sh"
    }
}
```

### Waybar Styles (~/.config/waybar/style.css)
```css
* {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 13px;
    border: none;
    border-radius: 0;
    min-height: 0;
}

window#waybar {
    background: rgba(26, 27, 38, 0.9);
    color: #c0caf5;
    border-radius: 10px;
    margin: 5px;
}

#workspaces button {
    padding: 0 10px;
    background: transparent;
    color: #565f89;
    border-radius: 5px;
    transition: all 0.3s ease;
}

#workspaces button.focused {
    background: #7aa2f7;
    color: #1a1b26;
    box-shadow: 0 2px 10px rgba(122, 162, 247, 0.5);
}

#workspaces button:hover {
    background: rgba(122, 162, 247, 0.3);
    color: #c0caf5;
}

#custom-arch {
    color: #7aa2f7;
    font-size: 16px;
    padding: 0 10px;
}

#cpu, #memory, #temperature, #custom-pacman, #pulseaudio, #network, #idle_inhibitor, #custom-gamemode, #custom-keybinds {
    background: rgba(122, 162, 247, 0.1);
    padding: 0 12px;
    margin: 0 2px;
    border-radius: 5px;
}

#custom-gamemode {
    transition: all 0.3s ease;
}

#custom-keybinds {
    color: #bb9af7;
}

#custom-keybinds:hover {
    background: rgba(187, 154, 247, 0.2);
    color: #bb9af7;
}

#pulseaudio.muted {
    background: rgba(247, 118, 142, 0.2);
    color: #f7768e;
}

#network.disconnected {
    background: rgba(247, 118, 142, 0.2);
    color: #f7768e;
}

#idle_inhibitor.activated {
    background: rgba(158, 206, 106, 0.2);
    color: #9ece6a;
}

#custom-power {
    background: #f7768e;
    color: #1a1b26;
    padding: 0 12px;
    border-radius: 5px;
    margin-left: 5px;
}
```

## 🎮 Gaming Optimizations

### AMD Performance Tweaks
```bash
# Add to ~/.bashrc or ~/.zshrc
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=aco,llvm
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi

# For older RX 580, ensure proper power management
echo 'KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"' | sudo tee /etc/udev/rules.d/30-amdgpu-pm.rules
```

### Gaming Launch Scripts
Create `~/.local/bin/game-launch.sh`:
```bash
#!/bin/bash
# Gaming mode launcher with optimizations

# Set CPU governor to performance
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Start gamemode
gamemoderun "$@"

# Restore CPU governor after game
echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

### ZRAM Configuration (/etc/systemd/zram-generator.conf)
```ini
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
```

## 🚀 Eww Game Launcher Widget

### Game Launcher Configuration (~/.config/eww/windows/game-launcher.yuck)
```lisp
(defwindow game-launcher
  :monitor 0
  :geometry (geometry :x "50%"
                      :y "50%"
                      :width "600px"
                      :height "400px"
                      :anchor "center")
  :stacking "overlay"
  :windowtype "dialog"
  
  (box :class "game-launcher"
       :orientation "v"
       :space-evenly false
    
    (box :class "launcher-header"
         (label :text "🎮 Game Launcher" 
                :class "launcher-title"))
    
    (box :class "game-grid"
         :orientation "h"
         :space-evenly true
      
      (button :class "game-btn steam"
              :onclick "steam &"
              (box :orientation "v"
                   (label :text "🎮" :class "game-icon")
                   (label :text "Steam" :class "game-name")))
      
      (button :class "game-btn lutris"
              :onclick "lutris &"
              (box :orientation "v"
                   (label :text "🍷" :class "game-icon")
                   (label :text "Lutris" :class "game-name")))
      
      (button :class "game-btn heroic"
              :onclick "heroic &"
              (box :orientation "v"
                   (label :text "🏛️" :class "game-icon")
                   (label :text "Heroic" :class "game-name"))))))
```

## 📋 Keybind Reference Script

Create `~/.config/scripts/keybinds.sh`:
```bash
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
• Autotiling is enabled - windows auto-arrange!
• Click waybar modules for quick actions
• Right-click audio icon to mute/unmute
• GameMode indicator shows current status
• Use Super + Mouse to drag floating windows
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
```

Make it executable:
```bash
chmod +x ~/.config/scripts/keybinds.sh
```

Create `~/.config/scripts/power-menu.sh`:
```bash
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
```

## 🪟 Autotiling Configuration

Autotiling automatically switches between horizontal and vertical splits based on window dimensions, making window management much more intuitive.

### Autotiling Customization (~/.config/autotiling/config.py)
```python
# Optional: Create custom autotiling config
import subprocess

def main():
    """Custom autotiling behavior"""
    # You can add custom rules here
    # For example, exclude certain applications from autotiling
    excluded_apps = ['Steam', 'spotify', 'pavucontrol']
    
    # Default autotiling behavior works great for most cases
    subprocess.run(['autotiling'])

if __name__ == "__main__":
    main()
```

## 🎮 GameMode Integration

GameMode optimizes your system for gaming performance. The toggle allows you to easily enable/disable it.

### GameMode Configuration (~/.config/gamemode.ini)
```ini
[general]
renice=10
ioprio=1

[filter]
whitelist=steam
whitelist=lutris
whitelist=heroic
whitelist=wine
whitelist=proton

[gpu]
apply_gpu_optimisations=accept
amd_performance_level=high

[cpu]
park_cores=no
pin_cores=no
```

### Enhanced GameMode Toggle Script (~/.local/bin/gamemode-toggle-enhanced.sh)
```bash
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
```

Make it executable:
```bash
chmod +x ~/.local/bin/gamemode-toggle-enhanced.sh
```

### Alternative Waybar GameMode Widget (with better styling)
```json
"custom/gamemode": {
    "format": "{icon} {}",
    "format-icons": {
        "on": "🎮",
        "off": "🎯"
    },
    "interval": 5,
    "exec": "if pgrep -x gamemoded > /dev/null; then echo 'on ON'; else echo 'off OFF'; fi",
    "on-click": "gamemode-toggle-enhanced.sh",
    "tooltip-format": "Click to toggle GameMode"
},
```

### SDDM Sugar Candy Theme
Edit `/usr/share/sddm/themes/sugar-candy/theme.conf`:
```ini
[General]
Background="tokyonight-login.jpg"
MainColor="#7aa2f7"
AccentColor="#f7768e"
BackgroundColor="#1a1b26"
OverrideLoginButtonTextColor="#1a1b26"
```

### Alacritty TokyoNight Theme (~/.config/alacritty/alacritty.yml)
```yaml
colors:
  primary:
    background: '#1a1b26'
    foreground: '#c0caf5'
  
  normal:
    black:   '#15161e'
    red:     '#f7768e'
    green:   '#9ece6a'
    yellow:  '#e0af68'
    blue:    '#7aa2f7'
    magenta: '#bb9af7'
    cyan:    '#7dcfff'
    white:   '#a9b1d6'

window:
  opacity: 0.95
  padding:
    x: 10
    y: 10
```

## 🚀 Final Setup Steps

1. **Install all packages** from the package lists above
2. **Apply configurations** to respective directories
3. **Download TokyoNight wallpapers** and place in `~/.config/wallpapers/`
4. **Enable services**:
   ```bash
   sudo systemctl enable sddm
   sudo systemctl enable zram-generator
   ```
5. **Set up nwg-look** for GTK theme management
6. **Configure game-launch scripts** and make executable
7. **Test SwayFX effects** and adjust blur/shadow settings for performance

## 💡 Performance Notes for Your Hardware

- **RX 580**: Excellent for 1080p gaming, RADV driver recommended
- **i5-4430**: 4 cores handle SwayFX well, zram helps with 8GB+ usage
- **FSYNC**: If using linux-zen kernel, fsync patches improve frame times
- **Gamescope**: Use for problematic games or when you want better control

This setup will give you a stunning cyberpunk aesthetic while maintaining excellent gaming performance on your hardware!
