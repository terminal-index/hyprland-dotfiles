#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="$HOME/.config"
BACKUP_TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [[ "$DOTFILES_DIR" == *"/dev/fd"* ]] || [ ! -d "$DOTFILES_DIR/.config" ]; then
    echo -e "${BLUE}[INFO]${NC} Running in bootstrap mode..."
    TARGET_DIR="$HOME/hyprland-dots"
    REPO_URL="https://github.com/terminal-index/hyprland-dots.git"

    if [ -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}[WARNING]${NC} Directory $TARGET_DIR already exists."
        read -p "Overwrite? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborting."
            exit 1
        fi
        rm -rf "$TARGET_DIR"
    fi

    echo -e "${BLUE}[INFO]${NC} Cloning repository..."
    if ! command -v git &> /dev/null; then
        echo -e "${RED}[ERROR]${NC} git is not installed. Please install git first from your package manager."
        exit 1
    fi

    git clone "$REPO_URL" "$TARGET_DIR"
    
    echo -e "${BLUE}[INFO]${NC} Relaunching installer from $TARGET_DIR..."
    chmod +x "$TARGET_DIR/install.sh"
    exec "$TARGET_DIR/install.sh" "$@"
fi

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        log_info "Detected distribution: $DISTRO"
    else
        log_error "Could not detect distribution via /etc/os-release."
        exit 1
    fi
}

install_gruvbox_theme() {
    log_info "Installing Gruvbox GTK Theme..."
    if [ -d "Gruvbox-GTK-Theme" ]; then rm -rf Gruvbox-GTK-Theme; fi
    git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git
    cd Gruvbox-GTK-Theme || exit
    ./install.sh -l -d "$HOME/.themes"
    cd ..
    rm -rf Gruvbox-GTK-Theme
    log_success "Gruvbox GTK Theme installed."
}

install_dependencies() {
    log_info "Installing dependencies for $DISTRO..."

    case $DISTRO in
        arch|manjaro|endeavouros|cachyos)
            PACKAGES=(
                zsh
                hyprland
                hyprlock
                hypridle
                hyprpaper
                waybar
                swaync
                rofi
                kitty
                nautilus
                wl-clipboard
                cliphist
                grim
                slurp
                btop
                yazi
                zathura
                zathura-pdf-mupdf
                imv
                ttf-jetbrains-mono-nerd
                brightnessctl
                playerctl
                wireplumber
                xdg-desktop-portal-hyprland
                polkit-kde-agent
                rust
                cargo
            )

            AUR_PACKAGES=(
                wlogout
                xwaylandvideobridge
                hyprpolkitagent
                eww
                nwg-look
                nwg-displays
                sassc
                gnome-themes-extra
                gtk-engine-murrine
                waypaper
            )

            sudo pacman -S --needed "${PACKAGES[@]}"

            if command -v yay &> /dev/null; then
                AUR_HELPER="yay"
            elif command -v paru &> /dev/null; then
                AUR_HELPER="paru"
            else
                echo -e "${YELLOW}No AUR helper found. Please choose one to install:${NC}"
                echo "1) yay"
                echo "2) paru"
                read -p "Enter choice [1-2]: " aur_choice

                case $aur_choice in
                    1)
                        log_info "Installing yay..."
                        sudo pacman -S --needed git base-devel
                        git clone https://aur.archlinux.org/yay.git
                        cd yay
                        makepkg -si
                        cd ..
                        rm -rf yay
                        AUR_HELPER="yay"
                        ;;
                    2)
                        log_info "Installing paru..."
                        sudo pacman -S --needed base-devel
                        git clone https://aur.archlinux.org/paru.git
                        cd paru
                        makepkg -si
                        cd ..
                        rm -rf paru
                        AUR_HELPER="paru"
                        ;;
                    *)
                        log_warn "Invalid choice. Skipping AUR helper installation."
                        ;;
                esac
            fi
            
            if [ -n "$AUR_HELPER" ]; then
                $AUR_HELPER -S --needed "${AUR_PACKAGES[@]}"
            else
                 log_error "Failed to setup AUR helper. Some packages may be missing: ${AUR_PACKAGES[*]}"
            fi

            if ! command -v niflveil &> /dev/null; then
                log_info "Installing NiflVeil (Manual Build)..."
                if [ -d "NiflVeil" ]; then rm -rf NiflVeil; fi
                git clone https://github.com/Mauitron/NiflVeil.git
                cd NiflVeil/niflveil || exit
                cargo build --release
                sudo cp target/release/niflveil /usr/local/bin/
                cd ../..
                rm -rf NiflVeil
                log_success "NiflVeil installed successfully."
            else
                log_success "NiflVeil is already installed."
            fi
            
            install_gruvbox_theme
            ;;

        fedora|nobara|bazzite)
            log_warn "Fedora support is experimental. Haven't used it in a long time, sooooo some package names may differ."
            sudo dnf install \
                zsh \
                hyprland \
                hyprlock \
                hypridle \
                hyprpaper \
                waybar \
                rofi \
                kitty \
                nautilus \
                wl-clipboard \
                grim \
                slurp \
                btop \
                brightnessctl \
                playerctl \
                zathura \
                zathura-pdf-mupdf \
                imv \
                jetbrains-mono-nerd-fonts \
                wireplumber \
                nwg-look \
                nwg-displays \
                sassc \
                gtk-murrine-engine \
                gnome-themes-extra
            
            log_warn "Fedora users need to manually install: swaync, wlogout, waypaper, and potentially niflveil from COPR or source. Check repo's README."
            
            install_gruvbox_theme
            ;;
        
        debian|ubuntu|pop)
             log_warn "Debian/Ubuntu support is limited. New hyprland versions may not be available in default repos. Try searching in PPA or build it manually."
             sudo apt update
             sudo apt install \
                zsh \
                kitty \
                nautilus \
                wl-clipboard \
                grim \
                slurp \
                btop \
                brightnessctl \
                playerctl \
                zathura \
                imv \
                wireplumber \
                nwg-look \
                sassc \
                gtk2-engines-murrine \
                gnome-themes-extra
             
             log_warn "You likely need to install hyprland, waybar (latest), nwg-displays, waypaper and others manually or via external repos."

             install_gruvbox_theme
             ;;

        *)
            log_error "Unsupported distribution: $DISTRO. Please install dependencies manually."
            ;;
    esac
}

link_config() {
    local target_name=$1
    local source_path="$DOTFILES_DIR/.config/$target_name"
    local config_path="$CONFIG_DIR/$target_name"

    log_info "Processing $target_name..."

    if [ ! -d "$source_path" ] && [ ! -f "$source_path" ]; then
        log_warn "Source $source_path does not exist. Skipping."
        return
    fi

    if [ -e "$config_path" ]; then
        if [ -L "$config_path" ] && [ "$(readlink -f "$config_path")" == "$source_path" ]; then
            log_success "$target_name is already correctly linked."
            return
        fi

        local backup_path="${config_path}.backup.${BACKUP_TIMESTAMP}"
        log_info "Backing up existing $target_name to $backup_path"
        mv "$config_path" "$backup_path"
    fi

    mkdir -p "$(dirname "$config_path")"

    ln -s "$source_path" "$config_path"
    log_success "Linked $target_name"
}

cat << "EOF"
|-------------------------------------------------------------|
| _____              _           _    ___         _           |
| |_   _|__ _ _ _ __ (_)_ _  __ _| |__|_ _|_ _  __| |_____ __ |
|   | |/ -_) '_| '  \| | ' \/ _` | |___| || ' \/ _` / -_) \ / |
|   |_|\___|_| |_|_|_|_|_||_\__,_|_|  |___|_||_\__,_\___/_\_\ |
|                                                             |
|      Created by @szoltysek                                  |
|      Gruvbox-themed Dotfiles Installer, version 1.0.0       |
|-------------------------------------------------------------|
EOF

detect_distro

read -p "Do you want to install dependencies? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_dependencies
else
    log_info "Skipping dependency installation."
fi

read -p "Do you want to link dotfiles? This will backup existing configs. (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    for dir in "$DOTFILES_DIR/.config"/*; do
        if [ -d "$dir" ]; then
            name=$(basename "$dir")
            link_config "$name"
        fi
    done

    log_success "Dotfiles linking complete."
else
    log_info "Skipping dotfiles linking."
fi

echo "|---------------------------------------------|"
echo "| Installation Complete!                      |"
echo "| Restart hyprland to use new configuration.  |"
echo "|---------------------------------------------|"
