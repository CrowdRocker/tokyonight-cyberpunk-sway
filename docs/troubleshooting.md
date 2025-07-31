# 🔧 Troubleshooting Guide

Common issues and solutions for TokyoNight Cyberpunk Sway setup.

## 🚨 Installation Issues

### Package Installation Failures

#### AUR Package Build Errors
**Problem**: `yay` fails to build AUR packages
```bash
# Error example:
==> ERROR: Failed to build swayfx-git
```

**Solutions**:
```bash
# Clear yay cache
yay -Sc

# Update keyring
sudo pacman -S archlinux-keyring
sudo pacman -Syu

# Rebuild package database
yay -Syy

# Try building with more verbose output
yay -S swayfx-git --debug
```

#### GPG Signature Issues
**Problem**: Package signature verification fails
```bash
# Error example:
error: package-name: signature from "..." is unknown trust
```

**Solutions**:
```bash
# Update keyring and refresh keys
sudo pacman -S archlinux-keyring
sudo pacman-key --refresh-keys

# If specific key issues persist
sudo pacman-key --recv-keys KEYID
sudo pacman-key --lsign-key KEYID
```

#### Dependencies Conflicts
**Problem**: Package conflicts during installation
```bash
# Error example:
conflicting dependencies: package1 and package2 are in conflict
```

**Solutions**:
```bash
# Check what's installed
pacman -Q | grep conflicting-package

# Remove conflicting package if safe
sudo pacman -R conflicting-package

# Force reinstall if necessary (use carefully)
sudo pacman -S --overwrite "*" package-name
```

## 🖥️ Display and Session Issues

### Sway Won't Start

#### Configuration Syntax Errors
**Problem**: Sway fails to start with config errors
```bash
# Error example:
sway: error: Expected 'output', 'workspace' or 'focus'
```

**Solutions**:
```bash
# Validate configuration
sway --validate

# Test with minimal config
cp ~/.config/sway/config ~/.config/sway/config.backup
cat > ~/.config/sway/config << EOF
# Minimal config for testing
exec alacritty
bindsym Mod4+Return exec alacritty
bindsym Mod4+Shift+q kill
EOF

# Start sway from TTY to see errors
sway
```

#### SwayFX Specific Issues
**Problem**: SwayFX effects cause crashes or performance issues
```bash
# Error example:
sway crashes when blur is enabled
```

**Solutions**:
```bash
# Disable effects temporarily
# In ~/.config/sway/config:
blur disable
shadows disable
corner_radius 0

# Reduce effect intensity
blur_passes 1
blur_radius 2
shadow_blur_radius 10

# Check GPU driver support
glxinfo | grep "OpenGL"
vulkaninfo | head -20
```

### SDDM Display Manager Issues

#### SDDM Theme Not Loading
**Problem**: Sugar Candy theme doesn't appear
```bash
# Default SDDM theme loads instead of Sugar Candy
```

**Solutions**:
```bash
# Check theme installation
ls -la /usr/share/sddm/themes/sugar-candy/

# Verify SDDM configuration
sudo cat /etc/sddm.conf

# Manual theme configuration
sudo tee /etc/sddm.conf << EOF
[Theme]
Current=sugar-candy
EOF

# Restart SDDM
sudo systemctl restart sddm
```

#### SDDM Resolution Issues
**Problem**: SDDM runs at wrong resolution
```bash
# Login screen appears at wrong resolution
```

**Solutions**:
```bash
# Create SDDM Xsetup script
sudo tee /usr/share/sddm/scripts/Xsetup << 'EOF'
#!/bin/sh
xrandr --output HDMI-1 --mode 1920x1080 --rate 60
EOF

sudo chmod +x /usr/share/sddm/scripts/Xsetup

# Or configure in SDDM conf
sudo tee -a /etc/sddm.conf << EOF
[X11]
ServerArguments=-nolisten tcp -dpi 96
EOF
```

## 🔊 Audio Issues

### No Audio Output

#### PipeWire Not Running
**Problem**: No sound, PipeWire services not active
```bash
# Check service status
systemctl --user
