# 📦 Installation Guide

Complete installation guide for TokyoNight Cyberpunk Sway on Arch Linux.

## 🔧 Prerequisites

### System Requirements
- **OS**: Arch Linux (or Arch-based distribution)
- **Architecture**: x86_64
- **RAM**: 8GB+ recommended (4GB minimum)
- **Storage**: 20GB+ free space
- **GPU**: AMD graphics card with Vulkan support (RX 580 or better recommended)

### Required Knowledge
- Basic command line usage
- Familiarity with Arch Linux package management
- Understanding of Wayland vs X11

## 🚀 Installation Methods

### Method 1: Automated Installation (Recommended)

The automated script handles everything for you:

```bash
# Clone the repository
git clone https://github.com/yourusername/tokyonight-cyberpunk-sway.git
cd tokyonight-cyberpunk-sway

# Make install script executable
chmod +x install.sh

# Run installation
./install.sh
```

**What the script does:**
1. Validates your system (Arch Linux, not root user)
2. Installs yay (AUR helper) if missing
3. Updates system packages
4. Installs all required packages
5. Creates configuration directories
6. Copies all configuration files
7. Sets up services and optimizations
8. Configures gaming optimizations

### Method 2: Manual Installation

If you prefer to install manually or want to understand each step:

#### Step 1: Install AUR Helper
```bash
# Install yay if not present
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

#### Step 2: Update System
```bash
sudo pacman -Syu
```

#### Step 3: Install Core Packages
```bash
# Wayland/Sway essentials
sudo pacman -S sway swayidle swaylock swaybg xorg-xwayland wl-clipboard grim slurp

# SwayFX (enhanced Sway)
yay -S swayfx-git

# Display manager
sudo pacman -S sddm qt5-graphicaleffects qt5-quickcontrols2
yay -S sddm-sugar-candy-git
```

#### Step 4: Install Audio System
```bash
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pavucontrol wireplumber
```

#### Step 5: Install UI Components
```bash
# Status bar and widgets
sudo pacman -S waybar
yay -S eww-git

# Launchers and utilities
yay -S nwg-drawer nwg-dock nwg-look
sudo pacman -S rofi-wayland azote thunar thunar-volman gvfs
```

#### Step 6: Install Terminal and Shell
```bash
sudo pacman -S alacritty xfce4-terminal starship zsh zsh-autosuggestions zsh-syntax-highlighting
```

#### Step 7: Install AMD Graphics Stack
```bash
sudo pacman -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk
```

#### Step 8: Install Gaming Components
```bash
# Core gaming
sudo pacman -S steam lutris gamemode gamescope wine-staging winetricks

# Additional gaming tools
yay -S heroic-games-launcher-bin gamemode-toggle-git
```

#### Step 9: Install Performance Tools
```bash
sudo pacman -S zram-generator htop btop neofetch python-i3ipc
yay -S autotiling
```

#### Step 10: Install Fonts
```bash
sudo pacman -S ttf-jetbrains-mono-nerd
fc-cache -fv
```

## 📁 Manual Configuration

If you're doing manual installation, you'll need to copy configuration files:

### Create Directories
```bash
mkdir -p ~/.config/{sway,waybar,alacritty,eww/windows,gamemode,autotiling,scripts}
mkdir -p ~/.config/wallpapers
mkdir -p ~/.local/bin
```

### Copy Configuration Files
```bash
# From the cloned repository
cp configs/sway/config ~/.config/sway/
cp configs/waybar/config ~/.config/waybar/
cp configs/waybar/style.css ~/.config/waybar/
cp configs/alacritty/alacritty.yml ~/.config/alacritty/
cp configs/eww/windows/game-launcher.yuck ~/.config/eww/windows/
cp configs/gamemode/gamemode.ini ~/.config/gamemode/
cp configs/autotiling/config.py ~/.config/autotiling/

# Copy scripts
cp scripts/*.sh ~/.config/scripts/
chmod +x ~/.config/scripts/*.sh
cp scripts/game-launch.sh ~/.local/bin/
cp scripts/gamemode-toggle-enhanced.sh ~/.local/bin/
chmod +x ~/.local/bin/*.sh

# Copy wallpapers
cp wallpapers/* ~/.config/wallpapers/

# System configurations (requires sudo)
sudo cp configs/zram/zram-generator.conf /etc/systemd/
sudo cp themes/sddm/theme.conf /usr/share/sddm/themes/sugar-candy/
```

## ⚙️ Service Configuration

### Enable Display Manager
```bash
sudo systemctl enable sddm
```

### Enable Audio Services
```bash
systemctl --user enable pipewire pipewire-pulse
```

### Enable Performance Services
```bash
sudo systemctl enable zram-generator
systemctl --user enable gamemoded
```

### Add User to GameMode Group
```bash
sudo usermod -a -G gamemode $USER
```

## 🎮 Gaming Optimizations

### AMD Environment Variables
Add to your shell configuration (~/.bashrc or ~/.zshrc):
```bash
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=aco,llvm
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi
```

### GPU Power Management
```bash
echo 'KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"' | \
sudo tee /etc/udev/rules.d/30-amdgpu-pm.rules
```

### Starship Prompt
```bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc
# or for zsh:
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

## 🚪 Session Configuration

### Create Sway Session Entry
```bash
sudo tee /usr/share/wayland-sessions/sway-cyberpunk.desktop > /dev/null << EOF
[Desktop Entry]
Name=Sway (TokyoNight Cyberpunk)
Comment=An i3-compatible Wayland compositor with cyberpunk theme
Exec=sway
Type=Application
EOF
```

## ✅ Post-Installation Verification

### Test Sway Configuration
```bash
# Validate Sway config (before logging in)
sway --validate

# Should return no errors
```

### Check Service Status
```bash
# Check audio services
systemctl --user status pipewire pipewire-pulse

# Check GameMode
systemctl --user status gamemoded

# Check ZRAM
sudo systemctl status systemd-zram-setup@zram0.service
```

### Verify GPU Setup
```bash
# Check Vulkan
vulkaninfo | grep "GPU id"

# Check Mesa
glxinfo | grep "OpenGL renderer"
```

## 🔄 First Login

1. **Reboot** your system
2. At the login screen, select **"Sway (TokyoNight Cyberpunk)"**
3. Log in with your credentials
4. You should see the TokyoNight desktop with Waybar

### First Boot Checklist
- [ ] Desktop loads with TokyoNight theme
- [ ] Waybar appears at the top
- [ ] Press `Super + Return` to test terminal
- [ ] Press `Super + K` for keybind reference
- [ ] Press `Super + Shift + G` to test GameMode toggle
- [ ] Audio works (test with pavucontrol)

## 🐛 Common Installation Issues

### Package Installation Fails
```bash
# Update keyring if signature issues
sudo pacman -S archlinux-keyring
sudo pacman -Syu
```

### AUR Package Issues
```bash
# Clear yay cache
yay -Sc

# Rebuild package database
yay -Syy
```

### SwayFX Won't Start
```bash
# Check if regular Sway works first
sway --validate

# Check for conflicting packages
pacman -Qs sway
```

### SDDM Theme Issues
```bash
# Verify theme files exist
ls -la /usr/share/sddm/themes/sugar-candy/

# Check SDDM configuration
sudo sddm --test-mode
```

### Audio Not Working
```bash
# Restart audio services
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check audio devices
pactl list short sinks
```

## 🔄 Updating the Setup

### Update Packages
```bash
# Update system packages
sudo pacman -Syu

# Update AUR packages
yay -Sua
```

### Update Configurations
```bash
# Pull latest configurations from repository
git pull origin main

# Re-run install script to update configs
./install.sh
```

## 🗑️ Uninstallation

If you need to remove the setup:

### Remove Packages (Optional)
```bash
# Remove AUR packages
yay -Rns swayfx-git eww-git nwg-drawer nwg-dock nwg-look sddm-sugar-candy-git

# Remove main packages (be careful - this removes Sway entirely)
sudo pacman -Rns sway waybar autotiling gamemode
```

### Remove Configurations
```bash
# Backup first if needed
cp -r ~/.config ~/.config.backup

# Remove configuration directories
rm -rf ~/.config/{sway,waybar,alacritty,eww,gamemode,autotiling,scripts}
rm -rf ~/.config/wallpapers
rm -f ~/.local/bin/{game-launch.sh,gamemode-toggle-enhanced.sh}

# Remove system configurations
sudo rm -f /etc/systemd/zram-generator.conf
sudo rm -f /etc/udev/rules.d/30-amdgpu-pm.rules
```

### Disable Services
```bash
sudo systemctl disable sddm
systemctl --user disable pipewire pipewire-pulse gamemoded
sudo systemctl disable zram-generator
```

---

**Next Steps**: After installation, check out [Configuration Guide](configuration.md) for customization options.
