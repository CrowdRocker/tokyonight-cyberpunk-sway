# ⚙️ Configuration Guide

Detailed configuration options for customizing your TokyoNight Cyberpunk Sway setup.

## 📁 Configuration Structure

```
~/.config/
├── sway/config              # Main Sway configuration
├── waybar/
│   ├── config              # Waybar modules configuration
│   └── style.css           # Waybar styling
├── alacritty/alacritty.yml # Terminal configuration
├── eww/windows/            # Eww widget definitions
├── gamemode/gamemode.ini   # GameMode settings
├── autotiling/config.py    # Autotiling customization
└── scripts/                # Custom scripts
```

## 🪟 Sway Configuration

### Basic Settings (`~/.config/sway/config`)

#### Variables and Colors
```bash
# TokyoNight color scheme
set $bg #1a1b26      # Background
set $fg #c0caf5      # Foreground
set $br #565f89      # Border
set $in #414868      # Inactive
set $ac #7aa2f7      # Accent (blue)
set $ur #f7768e      # Urgent (red)
set $gr #9ece6a      # Green
set $yl #e0af68      # Yellow
set $pu #bb9af7      # Purple
set $cy #7dcfff      # Cyan

# Custom color variations
set $bg_dark #16161e    # Darker background
set $bg_light #24283b   # Lighter background
```

#### SwayFX Effects
```bash
# Blur settings
blur enable
blur_xray disable
blur_passes 2           # Higher = more blur, lower performance
blur_radius 3           # Blur radius

# Corner rounding
corner_radius 10        # Adjust for more/less rounding

# Shadows
shadows enable
shadow_blur_radius 20   # Shadow blur amount
shadow_color #000000AA  # Shadow color with transparency
```

#### Window Management
```bash
# Gaps
gaps inner 8            # Gap between windows
gaps outer 4            # Gap from screen edge

# Borders
default_border pixel 2
default_floating_border pixel 2

# Focus behavior
focus_follows_mouse yes
focus_on_window_activation smart
```

#### Custom Keybindings
Add your own keybindings to the Sway config:
```bash
# Custom application shortcuts
bindsym $mod+b exec firefox-developer-edition
bindsym $mod+c exec code
bindsym $mod+m exec discord
bindsym $mod+g exec steam

# Screenshot shortcuts
bindsym Print exec grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png
bindsym $mod+Print exec grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png

# Volume control (if not using media keys)
bindsym $mod+equal exec pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym $mod+minus exec pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym $mod+0 exec pactl set-sink-mute @DEFAULT_SINK@ toggle
```

## 📊 Waybar Configuration

### Module Configuration (`~/.config/waybar/config`)

#### Adding New Modules
```json
{
    "modules-right": [
        "custom/pacman",
        "temperature",
        "cpu",
        "memory",
        "disk",
        "custom/weather",      // Add weather
        "custom/spotify",      // Add Spotify
        "custom/gamemode",
        "pulseaudio",
        "bluetooth",
        "network",
        "idle_inhibitor",
        "custom/keybinds",
        "custom/power"
    ]
}
```

#### Weather Module
```json
"custom/weather": {
    "format": "{}",
    "interval": 1800,
    "exec": "curl -s 'wttr.in/Lincoln,Nebraska?format=%c+%t' 2>/dev/null || echo '🌤️ N/A'",
    "tooltip": false
}
```

#### Spotify Module
```json
"custom/spotify": {
    "format": " {}",
    "max-length": 40,
    "interval": 1,
    "exec": "playerctl metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || echo 'Not playing'",
    "on-click": "playerctl play-pause",
    "on-scroll-up": "playerctl next",
    "on-scroll-down": "playerctl previous"
}
```

#### Custom System Info
```json
"custom/uptime": {
    "format": "⏱️ {}",
    "interval": 60,
    "exec": "uptime -p | sed 's/up //'"
},

"custom/kernel": {
    "format": " {}",
    "interval": 3600,
    "exec": "uname -r"
}
```

### Waybar Styling (`~/.config/waybar/style.css`)

#### Color Customization
```css
/* Custom color variables */
:root {
    --bg: #1a1b26;
    --fg: #c0caf5;
    --accent: #7aa2f7;
    --red: #f7768e;
    --green: #9ece6a;
    --yellow: #e0af68;
    --purple: #bb9af7;
    --cyan: #7dcfff;
}

/* Use variables in styling */
window#waybar {
    background: rgba(26, 27, 38, 0.9);
    color: var(--fg);
}

#workspaces button.focused {
    background: var(--accent);
    color: var(--bg);
}
```

#### Module-Specific Styling
```css
/* Weather module */
#custom-weather {
    background: rgba(158, 206, 106, 0.1);
    color: #9ece6a;
}

/* Spotify module */
#custom-spotify {
    background: rgba(29, 185, 84, 0.1);
    color: #1db954;
}

/* High temperature warning */
#temperature.critical {
    background: rgba(247, 118, 142, 0.3);
    color: #f7768e;
    animation: blink 1s infinite;
}

@keyframes blink {
    0%, 50% { opacity: 1; }
    51%, 100% { opacity: 0.5; }
}
```

#### Bar Positioning and Size
```css
window#waybar {
    /* Position: top, bottom */
    /* Size adjustments */
    margin: 5px 10px 0px 10px;  /* top, right, bottom, left */
    border-radius: 15px;
    
    /* Transparency */
    background: rgba(26, 27, 38, 0.95);
    
    /* Font size */
    font-size: 14px;
}
```

## 🖥️ Terminal Configuration

### Alacritty (`~/.config/alacritty/alacritty.yml`)

#### Color Schemes
```yaml
# Alternative TokyoNight color schemes

# TokyoNight Storm
colors:
  primary:
    background: '#24283b'
    foreground: '#c0caf5'
  normal:
    black:   '#1d202f'
    red:     '#f7768e'
    green:   '#9ece6a'
    yellow:  '#e0af68'
    blue:    '#7aa2f7'
    magenta: '#bb9af7'
    cyan:    '#7dcfff'
    white:   '#a9b1d6'

# TokyoNight Light (for daytime use)
# colors:
#   primary:
#     background: '#d5d6db'
#     foreground: '#565a6e'
#   normal:
#     black:   '#0f0f14'
#     red:     '#8c4351'
#     green:   '#33635c'
#     yellow:  '#8f5e15'
#     blue:    '#34548a'
#     magenta: '#5a4a78'
#     cyan:    '#0f4b6e'
#     white:   '#343b58'
```

#### Font Configuration
```yaml
font:
  normal:
    family: "JetBrainsMono Nerd Font"
    style: Regular
  bold:
    family: "JetBrainsMono Nerd Font"
    style: Bold
  italic:
    family: "JetBrainsMono Nerd Font"
    style: Italic
  
  size: 12.0
  
  # Alternative fonts to try:
  # family: "Fira Code Nerd Font"
  # family: "Hack Nerd Font"
  # family: "Source Code Pro"
```

#### Window Settings
```yaml
window:
  opacity: 0.95          # Transparency (0.0 - 1.0)
  blur: true             # Enable background blur (SwayFX)
  
  padding:
    x: 15
    y: 15
  
  dynamic_padding: true
  decorations: none      # Remove title bar
  startup_mode: Windowed
  
  # Alternative decorations:
  # decorations: full    # Keep title bar
```

## 🎮 Gaming Configuration

### GameMode (`~/.config/gamemode/gamemode.ini`)

#### Performance Settings
```ini
[general]
renice=10              # Process priority (lower = higher priority)
ioprio=1               # I/O priority (0=highest, 7=lowest)

# CPU settings
[cpu]
park_cores=no          # Don't park CPU cores
pin_cores=no           # Don't pin processes to cores
gov=performance        # CPU governor when GameMode active

# GPU settings  
[gpu]
apply_gpu_optimisations=accept
amd_performance_level=high

# Custom scripts
[custom]
start=notify-send "GameMode" "Activated" -t 2000
end=notify-send "GameMode" "Deactivated" -t 2000

# Game-specific settings
[filter]
whitelist=steam
whitelist=lutris  
whitelist=heroic
whitelist=wine
whitelist=proton
whitelist=gamemode

# Blacklist applications that shouldn't use GameMode
blacklist=firefox
blacklist=discord
```

### Steam Launch Options
Add these to game properties in Steam:
```bash
# For most games
gamemoderun %command%

# For Proton games with additional optimizations
RADV_PERFTEST=aco,llvm gamemoderun %command%

# For games that need specific GPU scheduling
MESA_VK_DEVICE_SELECT=1002:67df gamemoderun %command%
```

## 🎨 Customization Options

### Wallpaper Management
```bash
# Set wallpaper with azote
azote

# Or manually with swaybg
swaybg -i ~/.config/wallpapers/your-wallpaper.jpg -m fill

# Add to Sway config for startup
exec swaybg -i ~/.config/wallpapers/tokyonight-city.jpg -m fill
```

### Theme Switching Script
Create `~/.config/scripts/theme-switch.sh`:
```bash
#!/bin/bash
# Theme switcher between dark/light TokyoNight

CURRENT_THEME=$(cat ~/.config/current-theme 2>/dev/null || echo "dark")

if [ "$CURRENT_THEME" = "dark" ]; then
    # Switch to light theme
    cp ~/.config/alacritty/alacritty-light.yml ~/.config/alacritty/alacritty.yml
    cp ~/.config/waybar/style-light.css ~/.config/waybar/style.css
    echo "light" > ~/.config/current-theme
    notify-send "Theme" "Switched to Light mode"
else
    # Switch to dark theme  
    cp ~/.config/alacritty/alacritty-dark.yml ~/.config/alacritty/alacritty.yml
    cp ~/.config/waybar/style-dark.css ~/.config/waybar/style.css
    echo "dark" > ~/.config/current-theme
    notify-send "Theme" "Switched to Dark mode"
fi

# Reload waybar
killall waybar
waybar &
```

### Workspace Configuration
```bash
# Custom workspace names in Sway config
set $ws1 "1:  Terminal"
set $ws2 "2:  Browser"  
set $ws3 "3:  Code"
set $ws4 "4:  Games"
set $ws5 "5:  Media"

# Assign applications to workspaces
assign [app_id="firefox"] $ws2
assign [class="Code"] $ws3
assign [class="Steam"] $ws4
assign [class="discord"] $ws5

# Workspace switching
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
# ... etc
```

## 🔧 Advanced Configuration

### Multi-Monitor Setup
```bash
# In Sway config - adjust for your monitors
output HDMI-A-1 resolution 1920x1080 position 0,0
output DP-1 resolution 2560x1440 position 1920,0

# Workspace assignment to monitors
workspace $ws1 output HDMI-A-1
workspace $ws2 output HDMI-A-1
workspace $ws3 output DP-1
workspace $ws4 output DP-1
```

### Custom Scripts Integration
```bash
# Add to Sway config
bindsym $mod+Shift+s exec ~/.config/scripts/screenshot.sh
bindsym $mod+Shift+c exec ~/.config/scripts/color-picker.sh
bindsym $mod+Shift+n exec ~/.config/scripts/night-mode.sh
```

### Eww Widget Customization
Modify `~/.config/eww/windows/game-launcher.yuck`:
```lisp
; Add more games to launcher
(button :class "game-btn minecraft"
        :onclick "minecraft-launcher &"
        (box :orientation "v"
             (label :text "🧱" :class "game-icon")
             (label :text "Minecraft" :class "game-name")))

; Add system info widget
(defwidget system-info []
  (box :class "system-info"
       :orientation "v"
    (label :text "🖥️ System Info")
    (label :text "CPU: ${round(EWW_CPU.avg, 0)}%")
    (label :text "RAM: ${round(EWW_RAM.used_mem_perc, 0)}%")
    (label :text "Temp: ${EWW_TEMPS.CORETEMP_PACKAGE_ID_0}°C")))
```

## 🔄 Configuration Backup

### Backup Script
Create `~/.config/scripts/backup-config.sh`:
```bash
#!/bin/bash
# Backup current configuration

BACKUP_DIR="$HOME/.config/backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup configurations
cp -r ~/.config/sway "$BACKUP_DIR/"
cp -r ~/.config/waybar "$BACKUP_DIR/"
cp -r ~/.config/alacritty "$BACKUP_DIR/"
cp -r ~/.config/eww "$BACKUP_DIR/"
cp -r ~/.config/gamemode "$BACKUP_DIR/"
cp -r ~/.config/scripts "$BACKUP_DIR/"

echo "Configuration backed up to $BACKUP_DIR"
```

### Restore Configuration
```bash
# List available backups
ls -la ~/.config/backups/

# Restore from backup
BACKUP_DATE="20240101-120000"  # Replace with your backup
cp -r ~/.config/backups/$BACKUP_DATE/* ~/.config/

# Reload Sway
swaymsg reload
```

---

**Next Steps**: Check out [Troubleshooting Guide](troubleshooting.md) for common issues and solutions.
