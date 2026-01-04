# Hyprland Gruvbox Dotfiles

![Hyprland Gruvbox Theme](https://raw.githubusercontent.com/terminal-index/hyprland-dotfiles/refs/heads/main/assets/hyprland.png)

A comprehensive, aesthetic, and functional Hyprland configuration featuring a **Gruvbox Material** theme. These dotfiles are designed to be plug-and-play while offering high customization.

## Features

- **Window Management**: Dwindle layout with custom animations and window rules.
- **Status Bar**: Custom `waybar` configuration with interactive modules.
- **Notifications**: `swaync` for beautiful and functional notifications.
- **App Launcher**: `rofi` with a matching Gruvbox theme.
- **Lock Screen**: Fully configured `hyprlock`, just set up your profile picture and you're good to go.
- **Idle Management**: `hypridle` - just works, so it's cool
- **Terminal**: `kitty` + `zsh` configuration (you can change it to anything else, but this is preconfigured already).
- **File Manager**: `yazi` (terminal-based) and `nautilus` (GUI).
- **Image Viewer**: `imv` for a lightweight and scriptable experience.
- **PDF Viewer**: `zathura` with a minimalist interface and Vim-like controls.
- **System Monitor**: `btop` with `gruvbox` theme
- **Custom Scripts**: Includes `gamemode` script for performance optimization.
- **Window Tools**: Integrated support for `niflveil` - you can minimize and restore windows with a shortcut.
- **Themes & Settings**: `nwg-look` for GTK theme management, `nwg-displays` for output configuration. Includes **Gruvbox-GTK-Theme**.

## Installation

### Automatic Installation (Recommended)

An installation script is provided to automate the setup process. It supports **Arch Linux**-based distros the best (including derivatives like Manjaro, EndeavourOS, CachyOS), with experimental support for Fedora and limited support for Debian/Ubuntu.

1. **Run the one-line installer**:
   ```bash
   bash <(curl -s https://raw.githubusercontent.com/terminal-index/hyprland-dotfiles/refs/heads/main/install.sh)
   ```
   
   This will clone the repository to `~/hyprland-dots` and start the installation script.

### Manual Cloning

If you prefer to clone manually:
   ```bash
   git clone https://github.com/terminal-index/hyprland-dots.git
   cd hyprland-dots
   chmod +x install.sh
   ./install.sh
   ```

   The script will:
   - Autodetect your distro
   - Install required dependencies (official & AUR/external).
   - Prompt you to select an AUR helper (`yay` or `paru`) if not found (Arch only).
   - Automatically compile and install `niflveil` (Arch only).
   - Backup your existing configurations.
   - Symlink the new dotfiles to `~/.config`.

### Manual Installation

If you prefer to install dependencies manually, here is the list of required software:

**Core**:
- `hyprland`
- `hyprlock`, `hypridle`, `hyprpaper`
- `xdg-desktop-portal-hyprland`
- `polkit-kde-agent` (or `hyprpolkitagent`)

**UI & Utilities**:
- `waybar`, `swaync`
- `rofi`
- `kitty`
- `nautilus` (or your preferred file manager)
- `imv` (image viewer)
- `zathura` (pdf viewer)
- `wl-clipboard`, `cliphist`
- `grim`, `slurp` (screenshots)
- `btop`, `yazi`
- `brightnessctl`, `playerctl`
- `wireplumber`
- `wlogout` (logout menu)
- `waypaper` (wallpaper utility)
- `hyprpaper` (wallpaper daemon)
- `nwg-look`, `nwg-displays` (Appearance & Display settings)
- `wl-paste` (clipboard manager)

**Used GTK Theme**:
- **Gruvbox-GTK-Theme**: [GitHub Repository](https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme).

**Used fonts**:
- `ttf-jetbrains-mono-nerd`

**External Tools**:
- **NiflVeil**: [GitHub Repository](https://github.com/Mauitron/NiflVeil) (Requires `rust`, `cargo` (both for compiling) and `eww`)
- **xwaylandvideobridge**: For screen sharing possibility.

## Configuration

### Monitors
This configuration relies on `nwg-displays` to generate the monitor configuration.
1. Run `nwg-displays` (from terminal or launcher).
2. Configure your monitors (resolution, position, scale).
3. Click "Apply" to save the configuration to `~/.config/hypr/monitors.conf`.

## Keybindings

~~Windows~~/Cmd key (`SUPER`) is the main key (as always!)

| Key Combination | Action |
|-----------------|--------|
| `SUPER + RETURN` | Open Terminal (`kitty`) |
| `SUPER + E` | Open File Manager (`nautilus`) |
| `SUPER + SPACE` | Open App Launcher (`rofi`) |
| `SUPER + Q` | Close active window |
| `SUPER + V` | Toggle floating |
| `SUPER + F` | Fullscreen |
| `SUPER + P` | Pseudo tiling |
| `SUPER + D` | Toggle split |
| `SUPER + L` | Lock screen (`hyprlock`) |
| `SUPER + SHIFT + R` | Restart Waybar |
| `SUPER + SHIFT + S` | Screenshot (region) - saves and copies image instantly |
| `CTRL + ALT + DELETE`| Logout menu (`wlogout`) |
| `SUPER + Arrows` | Move focus |
| `SUPER + SHIFT + Arrows` | Swap window |
| `SUPER + 1-9` | Switch workspace |
| `SUPER + SHIFT + 1-9` | Move window to workspace |
| `SUPER + Scroll` | Change workspace |

## Structure

- `.config/hypr/`: Main Hyprland configuration
- `.config/waybar/`: Status bar style and config
- `.config/rofi/`: App launcher theme
- `.config/swaync/`: Notification center config
- `.config/kitty/`: Terminal setup
- `.config/btop/`: System monitor theme

## Issues

If you encounter any problems, please open an issue on the [GitHub repository](https://github.com/terminal-index/hyprland-dots/issues).

## Credits

- **Theme Inspiration**: [Gruvbox](https://github.com/morhetz/gruvbox)
- Alexays for his work on **Waybar**: [GitHub Repository](https://github.com/Alexays/Waybar)
- **Hyprland**: [The Hyprland Community](https://hyprland.org/)
- Mauitron for his great work on **NiflVeil**: [GitHub Repository](https://github.com/Mauitron/NiflVeil)
- Fausto-Korpsvart for his work on **Gruvbox GTK Theme**: [GitHub Repository](https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme)
- JetBrains' **Mono Font**: [Website](https://www.jetbrains.com/lp/mono/)
