# 🎨 Customization Guide

Advanced customization options for personalizing your TokyoNight Cyberpunk Sway setup.

## 🌈 Color Scheme Customization

### Creating Custom Color Variants

#### TokyoNight Color Variations
```bash
# Original TokyoNight Night
BG="#1a1b26"    # Dark background
FG="#c0caf5"    # Light foreground
BLUE="#7aa2f7"  # Accent blue
RED="#f7768e"   # Error/urgent red
GREEN="#9ece6a" # Success green
YELLOW="#e0af68" # Warning yellow
PURPLE="#bb9af7" # Secondary purple
CYAN="#7dcfff"   # Info cyan

# TokyoNight Storm (softer)
BG="#24283b"    # Slightly lighter
FG="#c0caf5"
BLUE="#7aa2f7"
RED="#f7768e"
GREEN="#9ece6a"
YELLOW="#e0af68"
PURPLE="#bb9af7" 
CYAN="#7dcfff"

# Custom Neon Variant (more cyberpunk)
BG="#0d1117"    # Darker background
FG="#e6edf3"    # Brighter foreground
BLUE="#58a6ff"  # Brighter blue
RED="#ff6b9d"   # Hot pink
GREEN="#39ff14" # Electric green
YELLOW="#ffff00" # Pure yellow
PURPLE="#bf00ff" # Electric purple
CYAN="#00ffff"   # Electric cyan
```

#### Applying Custom Colors
Create `~/.config/scripts/apply-colors.sh`:
```bash
#!/bin/bash
# Color scheme applier

# Color definitions
declare -A COLORS=(
    ["bg"]="#1a1b26"
    ["fg"]="#c0caf5"
    ["blue"]="#7aa2f7"
    ["red"]="#f7768e"
    ["green"]="#9ece6a"
    ["yellow"]="#e0af68"
    ["purple"]="#bb9af7"
    ["cyan"]="#7dcfff"
)

# Function to apply colors to Waybar
apply_waybar_colors() {
    sed -i "s/--bg: #[0-9a-fA-F]\{6\}/--bg: ${COLORS[bg]}/g" ~/.config/waybar/style.css
    sed -i "s/--fg: #[0-9a-fA-F]\{6\}/--fg: ${COLORS[fg]}/g" ~/.config/waybar/style.css
    sed -i "s/--accent: #[0-9a-fA-F]\{6\}/--accent: ${COLORS[blue]}/g" ~/.config/waybar/style.css
    
    # Reload Waybar
    killall waybar
    waybar &
}

# Function to apply colors to Alacritty
apply_alacritty_colors() {
    cat > ~/.config/alacritty/colors.yml << EOF
colors:
  primary:
    background: '${COLORS[bg]}'
    foreground: '${COLORS[fg]}'
  normal:
    black:   '#15161e'
    red:     '${COLORS[red]}'
    green:   '${COLORS[green]}'
    yellow:  '${COLORS[yellow]}'
    blue:    '${COLORS[blue]}'
    magenta: '${COLORS[purple]}'
    cyan:    '${COLORS[cyan]}'
    white:   '#a9b1d6'
EOF
}

# Apply all colors
apply_waybar_colors
apply_alacritty_colors

notify-send "Colors Applied" "Custom color scheme activated"
```

### Dynamic Color Switching
Create `~/.config/scripts/color-picker.sh`:
```bash
#!/bin/bash
# Interactive color scheme picker

SCHEMES_DIR="$HOME/.config/color-schemes"
mkdir -p "$SCHEMES_DIR"

# Create predefined schemes
create_schemes() {
    # TokyoNight Night
    cat > "$SCHEMES_DIR/tokyonight-night.conf" << EOF
BG="#1a1b26"
FG="#c0caf5"
ACCENT="#7aa2f7"
RED="#f7768e"
GREEN="#9ece6a"
YELLOW="#e0af68"
PURPLE="#bb9af7"
CYAN="#7dcfff"
EOF

    # TokyoNight Storm
    cat > "$SCHEMES_DIR/tokyonight-storm.conf" << EOF
BG="#24283b"
FG="#c0caf5"
ACCENT="#7aa2f7"
RED="#f7768e"
GREEN="#9ece6a"
YELLOW="#e0af68"
PURPLE="#bb9af7"
CYAN="#7dcfff"
EOF

    # Cyberpunk Neon
    cat > "$SCHEMES_DIR/cyberpunk-neon.conf" << EOF
BG="#0d1117"
FG="#e6edf3"
ACCENT="#58a6ff"
RED="#ff6b9d"
GREEN="#39ff14"
YELLOW="#ffff00"
PURPLE="#bf00ff"
CYAN="#00ffff"
EOF
}

# Select scheme with rofi
select_scheme() {
    local schemes=($(ls "$SCHEMES_DIR"/*.conf | xargs -n 1 basename -s .conf))
    local selected=$(printf '%s\n' "${schemes[@]}" | rofi -dmenu -p "Choose Color Scheme")
    
    if [[ -n "$selected" ]]; then
        source "$SCHEMES_DIR/$selected.conf"
        apply_scheme
        echo "$selected" > ~/.config/current-scheme
    fi
}

# Apply selected scheme
apply_scheme() {
    # Update Sway colors
    sed -i "s/set \$bg #[0-9a-fA-F]\{6\}/set \$bg $BG/g" ~/.config/sway/config
    sed -i "s/set \$fg #[0-9a-fA-F]\{6\}/set \$fg $FG/g" ~/.config/sway/config
    sed -i "s/set \$ac #[0-9a-fA-F]\{6\}/set \$ac $ACCENT/g" ~/.config/sway/config
    
    # Reload Sway
    swaymsg reload
    
    notify-send "Color Scheme" "Applied $selected scheme"
}

create_schemes
select_scheme
```

## 🖼️ Wallpaper Management

### Dynamic Wallpaper System
Create `~/.config/scripts/wallpaper-manager.sh`:
```bash
#!/bin/bash
# Advanced wallpaper management

WALLPAPER_DIR="$HOME/.config/wallpapers"
CURRENT_WALLPAPER="$HOME/.config/current-wallpaper"

# Wallpaper categories
declare -A CATEGORIES=(
    ["cyberpunk"]="$WALLPAPER_DIR/cyberpunk"
    ["tokyonight"]="$WALLPAPER_DIR/tokyonight"
    ["minimal"]="$WALLPAPER_DIR/minimal"
    ["animated"]="$WALLPAPER_DIR/animated"
)

# Create category directories
setup_directories() {
    for category in "${CATEGORIES[@]}"; do
        mkdir -p "$category"
    done
}

# Time-based wallpaper switching
time_based_wallpaper() {
    local hour=$(date +%H)
    local wallpaper=""
    
    if [[ $hour -ge 6 && $hour -lt 12 ]]; then
        # Morning - lighter wallpapers
        wallpaper=$(find "${CATEGORIES[minimal]}" -type f | shuf -n 1)
    elif [[ $hour -ge 12 && $hour -lt 18 ]]; then
        # Afternoon - tokyonight themes
        wallpaper=$(find "${CATEGORIES[tokyonight]}" -type f | shuf -n 1)
    else
        # Evening/Night - cyberpunk themes
        wallpaper=$(find "${CATEGORIES[cyberpunk]}" -type f | shuf -n 1)
    fi
    
    if [[ -n "$wallpaper" ]]; then
        set_wallpaper "$wallpaper"
    fi
}

# Random wallpaper from category
random_wallpaper() {
    local category="$1"
    if [[ -d "${CATEGORIES[$category]}" ]]; then
        local wallpaper=$(find "${CATEGORIES[$category]}" -type f | shuf -n 1)
        set_wallpaper "$wallpaper"
    fi
}

# Set wallpaper with effects
set_wallpaper() {
    local wallpaper="$1"
    
    # Kill existing swaybg
    pkill swaybg
    
    # Set new wallpaper
    swaybg -i "$wallpaper" -m fill &
    
    # Save current wallpaper
    echo "$wallpaper" > "$CURRENT_WALLPAPER"
    
    # Extract dominant colors for dynamic theming
    extract_colors "$wallpaper"
}

# Extract colors from wallpaper for dynamic theming
extract_colors() {
    local wallpaper="$1"
    
    # Requires imagemagick
    if command -v convert &> /dev/null; then
        # Extract primary colors
        local colors=$(convert "$wallpaper" -resize 50x50! -quantize RGB -colors 8 -format "%c" histogram:info: | head -3)
        
        # Apply extracted colors (simplified)
        notify-send "Wallpaper" "Set to $(basename "$wallpaper")"
    fi
}

# Interactive wallpaper selection
interactive_selection() {
    local wallpapers=($(find "$WALLPAPER_DIR" -type f -name "*.jpg" -o -name "*.png" | sort))
    local selected=""
    
    # Create preview thumbnails (requires imagemagick)
    for wallpaper in "${wallpapers[@]}"; do
        local thumb="$WALLPAPER_DIR/.thumbnails/$(basename "$wallpaper")"
        mkdir -p "$(dirname "$thumb")"
        if [[ ! -f "$thumb" ]] && command -v convert &> /dev/null; then
            convert "$wallpaper" -resize 200x200 "$thumb" 2>/dev/null
        fi
    done
    
    # Use rofi for selection
    selected=$(printf '%s\n' "${wallpapers[@]}" | xargs -n 1 basename | rofi -dmenu -p "Choose Wallpaper")
    
    if [[ -n "$selected" ]]; then
        local full_path=$(find "$WALLPAPER_DIR" -name "$selected" -type f | head -1)
        set_wallpaper "$full_path"
    fi
}

# Main function
case "$1" in
    "time")
        time_based_wallpaper
        ;;
    "random")
        random_wallpaper "${2:-cyberpunk}"
        ;;
    "select")
        interactive_selection
        ;;
    *)
        echo "Usage: $0 {time|random [category]|select}"
        echo "Categories: cyberpunk, tokyonight, minimal, animated"
        ;;
esac

setup_directories
```

### Animated Wallpapers
For animated wallpapers using `mpvpaper`:
```bash
# Install mpvpaper
yay -S mpvpaper

# Set animated wallpaper
mpvpaper -p -o "no-audio --loop" '*' ~/.config/wallpapers/animated/cyberpunk-rain.mp4

# Add to Sway config for startup
exec mpvpaper -p -o "no-audio --loop" '*' ~/.config/wallpapers/animated/default.mp4
```

## 🚀 Advanced Eww Widgets

### System Monitor Widget
Create `~/.config/eww/widgets/system-monitor.yuck`:
```lisp
(defwidget system-monitor []
  (box :class "system-monitor"
       :orientation "v"
       :spacing 10
    
    (box :class "monitor-header"
         (label :text "🖥️ System Monitor" :class "widget-title"))
    
    ; CPU Usage with bar
    (box :class "cpu-monitor"
         :orientation "h"
         :spacing 5
      (label :text "CPU:" :class "monitor-label")
      (progress :value {EWW_CPU.avg}
                :class "cpu-bar")
      (label :text "${round(EWW_CPU.avg, 0)}%" :class "monitor-value"))
    
    ; Memory Usage
    (box :class "memory-monitor"
         :orientation "h"
         :spacing 5
      (label :text "RAM:" :class "monitor-label")
      (progress :value {EWW_RAM.used_mem_perc}
                :class "memory-bar")
      (label :text "${round(EWW_RAM.used_mem_perc, 0)}%" :class "monitor-value"))
    
    ; GPU Temperature (if available)
    (box :class "temp-monitor"
         :orientation "h"
         :spacing 5
      (label :text "GPU:" :class "monitor-label")
      (label :text "${gpu_temp}°C" :class "monitor-value"))
    
    ; Disk Usage
    (box :class "disk-monitor"
         :orientation "h"
         :spacing 5
      (label :text "Disk:" :class "monitor-label")
      (progress :value {EWW_DISK["/"].used_perc}
                :class "disk-bar")
      (label :text "${round(EWW_DISK["/"].used_perc, 0)}%" :class "monitor-value"))))

; Variables for GPU temperature
(defvar gpu_temp "0")
(deflisten gpu_temp :initial "0"
  "sensors | grep 'edge' | awk '{print $2}' | sed 's/+//;s/°C//' | head -1")
```

### Weather Widget
Create `~/.config/eww/widgets/weather.yuck`:
```lisp
(defwidget weather []
  (box :class "weather-widget"
       :orientation "v"
       :spacing 5
    
    (box :class "weather-current"
         :orientation "h"
         :spacing 10
      (label :text "${weather_icon}" :class "weather-icon")
      (box :orientation "v"
           (label :text "${weather_temp}" :class "weather-temp")
           (label :text "${weather_desc}" :class "weather-desc")))
    
    (box :class "weather-details"
         :orientation "h"
         :spacing 5
      (label :text "💨 ${weather_wind}" :class "weather-detail")
      (label :text "💧 ${weather_humidity}" :class "weather-detail"))))

; Weather variables
(defvar weather_icon "🌤️")
(defvar weather_temp "20°C")
(defvar weather_desc "Partly Cloudy")
(defvar weather_wind "5 km/h")
(defvar weather_humidity "65%")

; Weather polling
(deflisten weather_data :initial "{}"
  "~/.config/scripts/weather-data.sh")
```

### Music Player Widget
Create `~/.config/eww/widgets/music-player.yuck`:
```lisp
(defwidget music-player []
  (box :class "music-player"
       :orientation "v"
       :spacing 5
    
    (box :class "music-info"
         :orientation "h"
         :spacing 10
      (image :path "${music_cover}"
             :image-width 60
             :image-height 60
             :class "music-cover")
      
      (box :orientation "v"
           :spacing 2
        (label :text "${music_title}" 
               :class "music-title"
               :limit-width 30)
        (label :text "${music_artist}"
               :class "music-artist"
               :limit-width 30)
        (label :text "${music_album}"
               :class "music-album"
               :limit-width 30)))
    
    ; Progress bar
    (box :class "music-progress"
         (progress :value {music_position / music_length * 100}
                   :class "music-progress-bar"))
    
    ; Control buttons
    (box :class "music-controls"
         :orientation "h"
         :spacing 10
         :halign "center"
      (button :onclick "playerctl previous" "⏮️")
      (button :onclick "playerctl play-pause" "${music_play_icon}")
      (button :onclick "playerctl next" "⏭️")
      (button :onclick "playerctl shuffle toggle" "🔀")
      (button :onclick "playerctl loop toggle" "🔁"))))

; Music variables
(defvar music_title "No Title")
(defvar music_artist "No Artist")
(defvar music_album "No Album")
(defvar music_cover "/usr/share/pixmaps/audio-x-generic.svg")
(defvar music_play_icon "⏸️")
(defvar music_position 0)
(defvar music_length 100)

; Music data polling
(deflisten music_data :initial "{}"
  "~/.config/scripts/music-data.sh")
```

## 🎛️ Advanced Waybar Customization

### Multi-Bar Setup
Create separate Waybar configs for different monitors:

**Primary Monitor** (`~/.config/waybar/config-primary`):
```json
{
    "output": "DP-1",
    "layer": "top",
    "position": "top",
    "height": 40,
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
    ]
}
```

**Secondary Monitor** (`~/.config/waybar/config-secondary`):
```json
{
    "output": "HDMI-A-1",
    "layer": "top",
    "position": "top",
    "height": 40,
    "modules-left": ["sway/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "custom/gamemode"]
}
```

**Start Multiple Waybars**:
```bash
# In Sway config
exec waybar --config ~/.config/waybar/config-primary &
exec waybar --config ~/.config/waybar/config-secondary &
```

### Custom Waybar Modules

#### System Uptime Module
```json
"custom/uptime": {
    "format": "⏱️ {}",
    "interval": 60,
    "exec": "uptime -p | sed 's/up //'",
    "tooltip": false
}
```

#### Package Count Module
```json
"custom/packages": {
    "format": "📦 {}",
    "interval": 3600,
    "exec": "pacman -Q | wc -l",
    "tooltip-format": "Installed packages"
}
```

#### VPN Status Module
```json
"custom/vpn": {
    "format": "{}",
    "interval": 5,
    "exec": "if pgrep -x openvpn > /dev/null; then echo '🔒 VPN'; else echo '🔓 No VPN'; fi",
    "on-click": "~/.config/scripts/vpn-toggle.sh"
}
```

#### GPU Usage Module (for AMD)
```json
"custom/gpu": {
    "format": "🎮 {}%",
    "interval": 2,
    "exec": "radeontop -d - -l 1 | grep -o 'gpu [0-9]*' | cut -d' ' -f2",
    "tooltip-format": "GPU Usage"
}
```

### Advanced Waybar Styling

#### Gradient Backgrounds
```css
#workspaces button.focused {
    background: linear-gradient(135deg, #7aa2f7 0%, #bb9af7 100%);
    color: #1a1b26;
    box-shadow: 0 2px 10px rgba(122, 162, 247, 0.5);
}

#custom-gamemode {
    background: linear-gradient(135deg, #f7768e 0%, #ff9e64 100%);
    color: #1a1b26;
}
```

#### Animated Elements
```css
@keyframes pulse {
    0% { opacity: 1; }
    50% { opacity: 0.7; }
    100% { opacity: 1; }
}

#custom-gamemode {
    animation: pulse 2s infinite;
}

@keyframes slide-in {
    from { transform: translateX(-100%); }
    to { transform: translateX(0); }
}

window#waybar {
    animation: slide-in 0.5s ease-out;
}
```

#### Responsive Design
```css
/* Adjust for different screen sizes */
@media (max-width: 1366px) {
    window#waybar {
        font-size: 12px;
    }
    
    #workspaces button {
        padding: 0 8px;
    }
}

@media (min-width: 2560px) {
    window#waybar {
        font-size: 16px;
        height: 50px;
    }
}
```

## 🎮 Gaming Environment Customization

### Game-Specific Optimizations
Create `~/.config/scripts/game-optimizer.sh`:
```bash
#!/bin/bash
# Game-specific optimization profiles

declare -A GAME_PROFILES=(
    ["steam"]="performance"
    ["lutris"]="performance"
    ["minecraft"]="balanced"
    ["discord"]="powersave"
    ["firefox"]="powersave"
)

# Apply optimization profile
apply_profile() {
    local app="$1"
    local profile="${GAME_PROFILES[$app]:-balanced}"
    
    case "$profile" in
        "performance")
            # Maximum performance
            echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            echo high | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
            # Disable compositor effects for performance
            swaymsg blur disable
            swaymsg shadows disable
            ;;
        "balanced")
            # Balanced performance
            echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            echo auto | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
            ;;
        "powersave")
            # Power saving
            echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            echo low | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
            # Re-enable compositor effects
            swaymsg blur enable
            swaymsg shadows enable
            ;;
    esac
    
    notify-send "Game Optimizer" "Applied $profile profile for $app"
}

# Monitor for game launches
monitor_games() {
    while true; do
        for app in "${!GAME_PROFILES[@]}"; do
            if pgrep -x "$app" > /dev/null; then
                if [[ ! -f "/tmp/optimizer_${app}" ]]; then
                    apply_profile "$app"
                    touch "/tmp/optimizer_${app}"
                fi
            else
                if [[ -f "/tmp/optimizer_${app}" ]]; then
                    apply_profile "default"
                    rm "/tmp/optimizer_${app}"
                fi
            fi
        done
        sleep 5
    done
}

case "$1" in
    "monitor")
        monitor_games
        ;;
    *)
        apply_profile "$1"
        ;;
esac
```

### Custom Game Launcher
Create `~/.config/scripts/custom-game-launcher.sh`:
```bash
#!/bin/bash
# Advanced game launcher with categories

GAMES_DIR="$HOME/.config/games"
mkdir -p "$GAMES_DIR"

# Game categories
declare -A CATEGORIES=(
    ["Steam Games"]="steam"
    ["Lutris Games"]="lutris" 
    ["Native Games"]="native"
    ["Emulators"]="emulators"
    ["Wine Games"]="wine"
)

# Scan for installed games
scan_steam_games() {
    if command -v steam &> /dev/null; then
        # Steam games scanning (simplified)
        local steam_dir="$HOME/.steam/steam/steamapps/common"
        if [[ -d "$steam_dir" ]]; then
            find "$steam_dir" -maxdepth 1 -type d | tail -n +2 | sort
        fi
    fi
}

scan_lutris_games() {
    if command -v lutris &> /dev/null; then
        lutris --list-games 2>/dev/null | grep -v "^$" | sort
    fi
}

# Create game launcher menu
create_launcher_menu() {
    local games_list="/tmp/games_list"
    > "$games_list"
    
    # Add Steam games
    echo "=== Steam Games ===" >> "$games_list"
    scan_steam_games | while read game; do
        echo "🎮 $(basename "$game")" >> "$games_list"
    done
    
    # Add Lutris games
    echo "=== Lutris Games ===" >> "$games_list"
    scan_lutris_games | while read game; do
        echo "🍷 $game" >> "$games_list"
    done
    
    # Add native games
    echo "=== Native Games ===" >> "$games_list"
    for app in minecraft-launcher discord-canary; do
        if command -v "$app" &> /dev/null; then
            echo "🐧 $app" >> "$games_list"
        fi
    done
    
    # Show launcher with rofi
    local selected=$(cat "$games_list" | rofi -dmenu -p "Launch Game" \
        -theme-str 'window {width: 60%; height: 70%;}' \
        -theme-str 'listview {lines: 20;}')
    
    if [[ -n "$selected" ]]; then
        launch_game "$selected"
    fi
    
    rm "$games_list"
}

# Launch selected game
launch_game() {
    local game="$1"
    local game_name=$(echo "$game" | sed 's/^[🎮🍷🐧] //')
    
    case "$game" in
        "🎮"*)
            # Steam game
            gamemoderun steam -applaunch $(get_steam_appid "$game_name")
            ;;
        "🍷"*)
            # Lutris game
            gamemoderun lutris lutris:rungame/"$game_name"
            ;;
        "🐧"*)
            # Native game
            gamemoderun "$game_name" &
            ;;
    esac
    
    # Apply game optimizations
    ~/.config/scripts/game-optimizer.sh "$game_name"
}

# Get Steam App ID (simplified)
get_steam_appid() {
    local game_name="$1"
    # This would need a proper Steam API implementation
    # For now, return a placeholder
    echo "0"
}

create_launcher_menu
```

## 🔧 Advanced System Tweaks

### Custom Sway Rules
Add advanced window rules to Sway config:
```bash
# Gaming applications
for_window [class="Steam"] floating enable, move position center
for_window [class="steamwebhelper"] floating enable
for_window [title="^Steam - News"] floating enable
for_window [class="Lutris"] move to workspace 4

# Development applications
for_window [app_id="code"] move to workspace 3
for_window [class="jetbrains-.*"] move to workspace 3

# Media applications  
for_window [app_id="mpv"] floating enable, resize set 1280 720, move position center
for_window [class="Spotify"] move to workspace 5

# System applications
for_window [app_id="pavucontrol"] floating enable, resize set 800 600
for_window [title="^pinentry"] floating enable

# Disable focus for certain windows
no_focus [title="^Steam - News"]
no_focus [class="steamwebhelper"]

# Transparency rules
for_window [app_id="alacritty"] opacity 0.95
for_window [app_id="code"] opacity 0.98

# Workspace auto-switching
for_window [urgent=latest] focus
```

### Performance Monitoring
Create `~/.config/scripts/performance-monitor.sh`:
```bash
#!/bin/bash
# System performance monitoring and alerts

TEMP_THRESHOLD=80
CPU_THRESHOLD=90
MEMORY_THRESHOLD=90

monitor_temperature() {
    local temp=$(sensors | grep 'Tctl' | awk '{print $2}' | sed 's/+//;s/°C//')
    if (( $(echo "$temp > $TEMP_THRESHOLD" | bc -l) )); then
        notify-send "Temperature Warning" "CPU: ${temp}°C" -u critical
        # Reduce performance if too hot
        ~/.config/scripts/game-optimizer.sh powersave
    fi
}

monitor_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        notify-send "CPU Warning" "Usage: ${cpu_usage}%" -u normal
    fi
}

monitor_memory() {
    local mem_usage=$(free | grep '^Mem' | awk '{printf "%.1f", $3/$2 * 100.0}')
    if (( $(echo "$mem_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        notify-send "Memory Warning" "Usage: ${mem_usage}%" -u normal
    fi
}

# Continuous monitoring
while true; do
    monitor_temperature
    monitor_cpu
    monitor_memory
    sleep 30
done
```

### Custom Keybind Manager
Create `~/.config/scripts/keybind-manager.sh`:
```bash
#!/bin/bash
# Dynamic keybind management

KEYBINDS_FILE="$HOME/.config/sway/keybinds.conf"
TEMP_KEYBINDS="/tmp/sway_keybinds"

# Gaming mode keybinds (minimal, game-focused)
gaming_keybinds() {
    cat > "$TEMP_KEYBINDS" << EOF
# Gaming mode keybinds
bindsym \$mod+Return exec alacritty
bindsym \$mod+Shift+q kill
bindsym \$mod+Shift+g exec gamemode-toggle
bindsym \$mod+f fullscreen toggle
bindsym \$mod+Tab workspace next
bindsym \$mod+Shift+Tab workspace prev

# Disable some distracting keybinds
# bindsym \$mod+d exec nwg-drawer
EOF
}

# Work mode keybinds (full productivity)
work_keybinds() {
    cat > "$TEMP_KEYBINDS" << EOF
# Work mode keybinds
bindsym \$mod+Return exec alacritty
bindsym \$mod+d exec nwg-drawer
bindsym \$mod+Shift+q kill
bindsym \$mod+e exec thunar
bindsym \$mod+b exec firefox-developer-edition
bindsym \$mod+c exec code
bindsym \$mod+k exec ~/.config/scripts/keybinds.sh

# Window management
bindsym \$mod+v split vertical
bindsym \$mod+h split horizontal
bindsym \$mod+f fullscreen toggle
bindsym \$mod+space floating toggle
EOF
}

# Apply keybind set
apply_keybinds() {
    local mode="$1"
    
    case "$mode" in
        "gaming")
            gaming_keybinds
            ;;
        "work")
            work_keybinds
            ;;
        *)
            echo "Usage: $0 {gaming|work}"
            exit 1
            ;;
    esac
    
    # Backup current keybinds
    cp "$KEYBINDS_FILE" "${KEYBINDS_FILE}.backup" 2>/dev/null || true
    
    # Apply new keybinds
    cp "$TEMP_KEYBINDS" "$KEYBINDS_FILE"
    
    # Reload Sway configuration
    swaymsg reload
    
    notify-send "Keybinds" "Switched to $mode mode"
}

apply_keybinds "$1"
```

## 🎨 Theme Management System

### Theme Manager Script
Create `~/.config/scripts/theme-manager.sh`:
```bash
#!/bin/bash
# Comprehensive theme management

THEMES_DIR="$HOME/.config/themes"
CURRENT_THEME_FILE="$HOME/.config/current-theme"

# Create theme directories
setup_theme_dirs() {
    mkdir -p "$THEMES_DIR"/{tokyonight-night,tokyonight-storm,cyberpunk-neon,minimal-dark}
    
    # Create theme templates
    create_theme_templates
}

# Create theme configuration templates
create_theme_templates() {
    # TokyoNight Night theme
    cat > "$THEMES_DIR/tokyonight-night/colors.conf" << EOF
BG="#1a1b26"
FG="#c0caf5"
ACCENT="#7aa2f7"
RED="#f7768e"
GREEN="#9ece6a"
YELLOW="#e0af68"
PURPLE="#bb9af7"
CYAN="#7dcfff"
EOF

    # Cyberpunk Neon theme
    cat > "$THEMES_DIR/cyberpunk-neon/colors.conf" << EOF
BG="#0d1117"
FG="#e6edf3"
ACCENT="#58a6ff"
RED="#ff6b9d"
GREEN="#39ff14"
YELLOW="#ffff00"
PURPLE="#bf00ff"
CYAN="#00ffff"
EOF
}

# Apply complete theme
apply_theme() {
    local theme_name="$1"
    local theme_dir="$THEMES_DIR/$theme_name"
    
    if [[ ! -d "$theme_dir" ]]; then
        echo "Theme $theme_name not found!"
        return 1
    fi
    
    # Load theme colors
    source "$theme_dir/colors.conf"
    
    # Apply to Sway
    apply_sway_theme
    
    # Apply to Waybar  
    apply_waybar_theme
    
    # Apply to Alacritty
    apply_alacritty_theme
    
    # Set wallpaper if theme has one
    if [[ -f "$theme_dir/wallpaper.jpg" ]]; then
        pkill swaybg
        swaybg -i "$theme_dir/wallpaper.jpg" -m fill &
    fi
    
    # Save current theme
    echo "$theme_name" > "$CURRENT_THEME_FILE"
    
    notify-send "Theme Manager" "Applied $theme_name theme"
}

# Theme-specific application functions
apply_sway_theme() {
    # Update Sway colors dynamically
    swaymsg client.focused "$ACCENT $ACCENT $FG $ACCENT $ACCENT"
    swaymsg client.unfocused "$BG $BG $FG $BG $BG"
}

apply_waybar_theme() {
    # Generate Waybar CSS with theme colors
    sed -i "s/--bg: #[0-9a-fA-F]\{6\}/--bg: $BG/g" ~/.config/waybar/style.css
    sed -i "s/--fg: #[0-9a-fA-F]\{6\}/--fg: $FG/g" ~/.config/waybar/style.css
    sed -i "s/--accent: #[0-9a-fA-F]\{6\}/--accent: $ACCENT/g" ~/.config/waybar/style.css
    
    # Reload Waybar
    killall waybar
    waybar &
}

apply_alacritty_theme() {
    # Generate Alacritty colors
    cat > ~/.config/alacritty/current-theme.yml << EOF
colors:
  primary:
    background: '$BG'
    foreground: '$FG'
  normal:
    black:   '#15161e'
    red:     '$RED'
    green:   '$GREEN'
    yellow:  '$YELLOW'
    blue:    '$ACCENT'
    magenta: '$PURPLE'
    cyan:    '$CYAN'
    white:   '#a9b1d6'
EOF
}

# Interactive theme selection
select_theme_interactive() {
    local themes=($(ls "$THEMES_DIR"))
    local selected=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -p "Choose Theme")
    
    if [[ -n "$selected" ]]; then
        apply_theme "$selected"
    fi
}

# Main function
case "$1" in
    "apply")
        apply_theme "$2"
        ;;
    "select")
        select_theme_interactive
        ;;
    "list")
        ls "$THEMES_DIR"
        ;;
    "setup")
        setup_theme_dirs
        ;;
    *)
        echo "Usage: $0 {apply <theme>|select|list|setup}"
        ;;
esac
```

## 🔄 Automation and Scripts

### Startup Script Manager
Create `~/.config/scripts/startup-manager.sh`:
```bash
#!/bin/bash
# Manage startup applications and services

STARTUP_DIR="$HOME/.config/startup-profiles"
mkdir -p "$STARTUP_DIR"

# Create startup profiles
create_profiles() {
    # Gaming profile
    cat > "$STARTUP_DIR/gaming.conf" << EOF
# Gaming startup profile
waybar
autotiling  
gamemoded
swaybg -i ~/.config/wallpapers/cyberpunk/gaming-bg.jpg -m fill
gamemode-toggle  # Start in GameMode
EOF

    # Work profile  
    cat > "$STARTUP_DIR/work.conf" << EOF
# Work startup profile
waybar
autotiling
firefox-developer-edition
code
discord
swaybg -i ~/.config/wallpapers/minimal/work-bg.jpg -m fill
EOF

    # Minimal profile
    cat > "$STARTUP_DIR/minimal.conf" << EOF
# Minimal startup profile
waybar
autotiling
swaybg -i ~/.config/wallpapers/minimal/clean-bg.jpg -m fill
EOF
}

# Apply startup profile
apply_profile() {
    local profile="$1"
    local profile_file="$STARTUP_DIR/$profile.conf"
    
    if [[ ! -f "$profile_file" ]]; then
        echo "Profile $profile not found!"
        return 1
    fi
    
    # Kill existing applications
    killall waybar 2>/dev/null || true
    killall swaybg 2>/dev/null || true
    
    # Start applications from profile
    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^#.*$ ]] && continue
        [[ -z "$line" ]] && continue
        
        # Execute command
        eval "$line &"
        sleep 0.5  # Small delay between starts
    done < "$profile_file"
    
    notify-send "Startup Manager" "Applied $profile profile"
}

# Interactive profile selection
select_profile() {
    local profiles=($(ls "$STARTUP_DIR" | sed 's/.conf//'))
    local selected=$(printf '%s\n' "${profiles[@]}" | rofi -dmenu -p "Choose Startup Profile")
    
    if [[ -n "$selected" ]]; then
        apply_profile "$selected"
    fi
}

case "$1" in
    "apply")
        apply_profile "$2"
        ;;
    "select")
        select_profile
        ;;
    "create")
        create_profiles
        ;;
    *)
        echo "Usage: $0 {apply <profile>|select|create}"
        ;;
esac
```

---

This comprehensive customization guide provides advanced options for personalizing every aspect of your TokyoNight Cyberpunk Sway setup. From dynamic color schemes and animated wallpapers to game-specific optimizations and complete theme management systems, you now have the tools to create a truly unique desktop environment that adapts to your workflow and preferences.
