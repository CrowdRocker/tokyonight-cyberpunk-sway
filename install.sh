#!/bin/bash

# TokyoNight Cyberpunk Sway Installation Script
# For Arch Linux with AMD RX 580 optimization

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║  🌃 TokyoNight Cyberpunk Sway Installation Script 🌃        ║
║                                                              ║
║  • SwayFX with blur effects and rounded corners             ║
║  • TokyoNight cyberpunk aesthetic                           ║
║  • AMD RX 580 gaming optimizations                          ║
║  • Comprehensive Waybar setup                               ║
║  • Autotiling and GameMode integration                      ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

# Check if running on Arch Linux
check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        print_error "This script is designed for Arch Linux. Exiting."
        exit 1
    fi
    print_status "Arch Linux detected ✓"
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "Don't run this script as root. Run as your user account."
        exit 1
    fi
    print_status "Running as user account ✓"
}

# Check for required tools
check_requirements() {
    print_step "Checking requirements..."

    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        print_warning "yay (AUR helper) not found. Installing yay..."
        sudo pacman -S --needed base-devel git
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd - > /dev/null
        print_status "yay installed ✓"
    else
        print_status "yay found ✓"
    fi

    # Update system
    print_status "Updating system packages..."
    sudo pacman -Syu --noconfirm
}

# Install packages
install_packages() {
    print_step "Installing packages..."

    # Core Wayland/Sway components
    print_status "Installing core Sway components..."
    sudo pacman -S --needed --noconfirm \
        sway swayidle swaylock swaybg \
        xorg-xwayland \
        wl-clipboard \
        grim slurp

    # Install SwayFX from AUR
    print_status "Installing SwayFX..."
    yay -S --noconfirm swayfx-git

    # Display and session management
    print_status "Installing display manager..."
    sudo pacman -S --needed --noconfirm \
        sddm qt5-graphicaleffects qt5-quickcontrols2
    yay -S --noconfirm sddm-sugar-candy-git

    # Audio stack
    print_status "Installing audio system..."
    sudo pacman -S --needed --noconfirm \
        pipewire pipewire-pulse pipewire-alsa \
        pavucontrol wireplumber

    # File management
    print_status "Installing file manager and utilities..."
    sudo pacman -S --needed --noconfirm \
        thunar thunar-volman gvfs \
        azote

    # Widgets and interface
    print_status "Installing UI components..."
    sudo pacman -S --needed --noconfirm waybar
    yay -S --noconfirm eww-git nwg-drawer nwg-dock nwg-look
    sudo pacman -S --needed --noconfirm rofi-wayland

    # Terminal and shell
    print_status "Installing terminal and shell..."
    sudo pacman -S --needed --noconfirm \
        alacritty xfce4-terminal \
        starship zsh zsh-autosuggestions zsh-syntax-highlighting

    # AMD drivers and Vulkan
    print_status "Installing AMD drivers..."
    sudo pacman -S --needed --noconfirm \
        mesa lib32-mesa \
        vulkan-radeon lib32-vulkan-radeon \
        amdvlk lib32-amdvlk

    # Gaming utilities
    print_status "Installing gaming stack..."
    sudo pacman -S --needed --noconfirm \
        steam lutris gamemode gamescope \
        wine-staging winetricks
    yay -S --noconfirm heroic-games-launcher-bin gamemode-toggle-git

    # Performance tools
    print_status "Installing performance tools..."
    sudo pacman -S --needed --noconfirm \
        zram-generator htop btop neofetch \
        python-i3ipc
    yay -S --noconfirm autotiling

    # Additional utilities
    print_status "Installing additional utilities..."
    sudo pacman -S --needed --noconfirm \
        firefox-developer-edition \
        discord \
        code \
        gimp \
        obs-studio \
        mpv \
        imv
}

# Create directories
create_directories() {
    print_step "Creating configuration directories..."

    mkdir -p ~/.config/{sway,waybar,alacritty,eww/windows,gamemode,autotiling,scripts}
    mkdir -p ~/.config/wallpapers
    mkdir -p ~/.local/bin
    mkdir -p ~/.local/share/fonts

    print_status "Directories created ✓"
}

# Install fonts
install_fonts() {
    print_step "Installing fonts..."

    # Install JetBrains Mono Nerd Font
    sudo pacman -S --needed --noconfirm ttf-jetbrains-mono-nerd

    # Update font cache
    fc-cache -fv

    print_status "Fonts installed ✓"
}

# Copy configuration files
copy_configs() {
    print_step "Copying configuration files..."

    # Sway configuration
    cp configs/sway/config ~/.config/sway/

    # Waybar configuration
    cp configs/waybar/config ~/.config/waybar/
    cp configs/waybar/style.css ~/.config/waybar/

    # Alacritty configuration
    cp configs/alacritty/alacritty.yml ~/.config/alacritty/

    # Eww configuration
    cp configs/eww/windows/game-launcher.yuck ~/.config/eww/windows/

    # GameMode configuration
    cp configs/gamemode/gamemode.ini ~/.config/gamemode/

    # Autotiling configuration
    cp configs/autotiling/config.py ~/.config/autotiling/

    # ZRAM configuration
    sudo cp configs/zram/zram-generator.conf /etc/systemd/

    # Scripts
    cp scripts/*.sh ~/.config/scripts/
    chmod +x ~/.config/scripts/*.sh

    # Copy to local bin
    cp scripts/game-launch.sh ~/.local/bin/
    cp scripts/gamemode-toggle-enhanced.sh ~/.local/bin/
    chmod +x ~/.local/bin/*.sh

    # Wallpapers
    cp wallpapers/* ~/.config/wallpapers/

    print_status "Configuration files copied ✓"
}

# Configure SDDM
configure_sddm() {
    print_step "Configuring SDDM..."

    # Copy SDDM theme configuration
    sudo cp themes/sddm/theme.conf /usr/share/sddm/themes/sugar-candy/

    # Set SDDM as default display manager
    sudo systemctl enable sddm

    print_status "SDDM configured ✓"
}

# Setup gaming optimizations
setup_gaming() {
    print_step "Setting up gaming optimizations..."

    # Add user to gamemode group
    sudo usermod -a -G gamemode $USER

    # Enable gamemode service
    systemctl --user enable gamemoded

    # AMD optimizations
    echo 'export AMD_VULKAN_ICD=RADV' >> ~/.bashrc
    echo 'export RADV_PERFTEST=aco,llvm' >> ~/.bashrc
    echo 'export MESA_LOADER_DRIVER_OVERRIDE=radeonsi' >> ~/.bashrc

    # GPU power management rule
    echo 'KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"' | \
        sudo tee /etc/udev/rules.d/30-amdgpu-pm.rules

    print_status "Gaming optimizations configured ✓"
}

# Enable services
enable_services() {
    print_step "Enabling services..."

    # Enable user services
    systemctl --user enable pipewire pipewire-pulse

    # Enable system services
    sudo systemctl enable zram-generator

    print_status "Services enabled ✓"
}

# Final setup
final_setup() {
    print_step "Final setup..."

    # Make sure starship is configured
    echo 'eval "$(starship init bash)"' >> ~/.bashrc

    # Create desktop entry for Sway session
    sudo tee /usr/share/wayland-sessions/sway-cyberpunk.desktop > /dev/null << EOF
[Desktop Entry]
Name=Sway (TokyoNight Cyberpunk)
Comment=An i3-compatible Wayland compositor with cyberpunk theme
Exec=sway
Type=Application
EOF

    print_status "Final setup completed ✓"
}

# Main installation function
main() {
    print_step "Starting TokyoNight Cyberpunk Sway installation..."

    check_arch
    check_root

    # Confirmation prompt
    echo -e "${YELLOW}"
    read -p "This will install and configure the TokyoNight Cyberpunk Sway desktop. Continue? (y/N): " -n 1 -r
    echo -e "${NC}"

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled."
        exit 0
    fi

    check_requirements
    install_packages
    create_directories
    install_fonts
    copy_configs
    configure_sddm
    setup_gaming
    enable_services
    final_setup

    echo -e "${GREEN}"
    cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║  🎉 Installation Complete! 🎉                               ║
║                                                              ║
║  Next steps:                                                 ║
║  1. Reboot your system                                       ║
║  2. Select "Sway (TokyoNight Cyberpunk)" at login           ║
║  3. Press Super + K for keybind reference                   ║
║  4. Press Super + Shift + G to toggle GameMode              ║
║                                                              ║
║  Enjoy your cyberpunk desktop! 🌃                           ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"

    print_warning "A reboot is recommended to ensure all services start correctly."
    read -p "Reboot now? (y/N): " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo reboot
    fi
}

# Error handling
trap 'print_error "Installation failed. Check the output above for details."' ERR

# Run main function
main "$@"
