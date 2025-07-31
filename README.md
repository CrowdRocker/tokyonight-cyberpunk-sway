# 🌃 TokyoNight Cyberpunk Sway

> A stunning cyberpunk desktop environment for Arch Linux with SwayFX, optimized for AMD gaming

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?logo=arch-linux&logoColor=fff)](#)
[![Sway](https://img.shields.io/badge/Sway-5294cf?logo=wayland&logoColor=fff)](#)
[![TokyoNight](https://img.shields.io/badge/TokyoNight-7aa2f7?logo=visual-studio-code&logoColor=fff)](#)
[![AMD](https://img.shields.io/badge/AMD-ED1C24?logo=amd&logoColor=fff)](#)

## 🎮 Features

- **🎨 TokyoNight Theme**: Deep purples, electric blues, and neon accents
- **✨ SwayFX Effects**: Blur, rounded corners, and smooth shadows
- **🎮 Gaming Optimized**: AMD-specific optimizations, GameMode integration
- **🖥️ Smart Widgets**: Eww game launcher, comprehensive Waybar
- **🪟 Auto-tiling**: Intelligent window management with autotiling
- **⚡ Performance**: FSYNC, Vulkan, ZRAM, and CPU governor management
- **🎵 Rich Interface**: Custom power menu, keybind reference, theme switching

## 📸 Preview

![Desktop Preview](preview/desktop.png)
*Main desktop with TokyoNight theme and cyberpunk aesthetics*

![Waybar](preview/waybar.png)
*Feature-rich Waybar with system monitoring and controls*

## 🖥️ System Requirements

### Recommended Hardware
- **CPU**: Intel i5-4430 or equivalent (4+ cores)
- **GPU**: AMD RX 580 or better (RADV driver recommended)
- **RAM**: 8GB+ (ZRAM configuration included)
- **Storage**: 20GB+ free space

### Software Requirements
- **OS**: Arch Linux (or Arch-based distro)
- **Kernel**: Linux 5.15+ (linux-zen recommended for gaming)
- **Display**: Wayland-compatible GPU drivers

## 🚀 Quick Installation

### One-Line Install
```bash
git clone https://github.com/CrowdRocker/tokyonight-cyberpunk-sway.git && cd tokyonight-cyberpunk-sway && chmod +x install.sh && ./install.sh
```

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/CrowdRocker/tokyonight-cyberpunk-sway.git
cd tokyonight-cyberpunk-sway

# Make install script executable
chmod +x install.sh

# Run installation (will prompt for confirmation)
./install.sh
```

## 📋 What Gets Installed

### Core Components
- **SwayFX**: Enhanced Sway with visual effects
- **Waybar**: Feature-rich status bar
- **Autotiling**: Intelligent window arrangement
- **GameMode**: Gaming performance optimization

### Applications
- **Terminal**: Alacritty with TokyoNight theme
- **File Manager**: Thunar with custom styling
- **Launcher**: nwg-drawer with cyberpunk styling
- **Lock Screen**: swaylock with blur effects

### Gaming Stack
- **Steam**: Gaming platform
- **Lutris**: Game manager for non-Steam games
- **Heroic**: Epic Games launcher
- **Gamescope**: Micro-compositor for better gaming

### Utilities
- **Audio**: PipeWire with pavucontrol
- **Wallpapers**: Azote wallpaper manager
- **Themes**: nwg-look for GTK theme management
- **System Monitor**: btop with TokyoNight theme

## ⚙️ Configuration

### Quick Setup
The install script handles most configuration automatically. After installation:

1. **Log out** and select "Sway" session
2. **First boot** will show the desktop with all components
3. **GameMode**: Press `Super + Shift + G` to toggle
4. **Keybinds**: Press `Super + K` for reference

### Key Bindings

| Keybind | Action |
|---------|--------|
| `Super + Return` | Terminal |
| `Super + D` | App launcher |
| `Super + Shift + G` | Toggle GameMode |
| `Super + K` | Keybind reference |
| `Super + L` | Lock screen |
| `Super + E` | File manager |

> Full keybind list available with `Super + K`

## 🎮 Gaming Optimization

### AMD-Specific Features
- **RADV driver** with ACO compiler
- **Vulkan optimizations** for RX 580
- **Power management** tuning
- **FSYNC patches** (linux-zen kernel)

### Performance Features
- **GameMode integration** with waybar indicator
- **CPU governor switching** (performance ↔ powersave)
- **ZRAM configuration** for better memory management
- **Game launch scripts** with automatic optimizations

### Supported Gaming Platforms
- ✅ **Steam** (native + Proton)
- ✅ **Lutris** (Wine/DXVK games)
- ✅ **Heroic** (Epic Games Store)
- ✅ **Native Linux games**

## 🎨 Customization

### Themes
- **Wallpapers**: Use Azote (`Super + W`) to change wallpapers
- **GTK Themes**: Use nwg-look (`Super + T`) for theme management
- **Colors**: Edit waybar CSS for custom color schemes

### Widgets
- **Waybar modules**: Easily add/remove modules in config
- **Eww widgets**: Custom game launcher and system widgets
- **Dock**: nwg-dock with gaming applications

## 📖 Documentation

- **[Installation Guide](docs/installation.md)**: Detailed installation steps
- **[Configuration](docs/configuration.md)**: Customization options
- **[Troubleshooting](docs/troubleshooting.md)**: Common issues and fixes
- **[Gaming Setup](docs/gaming.md)**: Optimize for specific games

## 🐛 Troubleshooting

### Common Issues

**SwayFX not starting?**
```bash
# Check Sway config syntax
sway --validate
```

**Gaming performance issues?**
```bash
# Verify GameMode is working
gamemoded --status
```

**Audio not working?**
```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse
```

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) first.

### Ways to Contribute
- 🐛 **Bug reports** and issue identification
- 💡 **Feature suggestions** and improvements  
- 🎨 **Theme variations** and color schemes
- 📖 **Documentation** improvements
- 🧪 **Testing** on different hardware

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **[TokyoNight](https://github.com/folke/tokyonight.nvim)** - Original color scheme inspiration
- **[SwayFX](https://github.com/WillPower3309/swayfx)** - Enhanced Sway compositor
- **[Waybar](https://github.com/Alexays/Waybar)** - Highly customizable status bar
- **Arch Linux Community** - For the amazing packages and documentation

## 💖 Support

If you like this project, consider:
- ⭐ **Starring** the repository
- 🐛 **Reporting bugs** you encounter  
- 💡 **Suggesting improvements**
- 📢 **Sharing** with fellow Linux enthusiasts

---

<div align="center">

**Made with 💜 for the Linux gaming community**

[Report Bug](https://github.com/CrowdRocker/tokyonight-cyberpunk-sway/issues) • [Request Feature](https://github.com/CrowdRocker/tokyonight-cyberpunk-sway/issues) • [Discussions](https://github.com/CrowdRocker/tokyonight-cyberpunk-sway/discussions)

</div>
