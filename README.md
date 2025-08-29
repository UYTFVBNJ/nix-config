# Unified Nix Configuration

This repository contains a unified Nix configuration for both macOS and NixOS systems, supporting both GUI and headless server configurations.

## Structure

```
nixos-config/
├── flake.nix                 # Main flake configuration
├── modules/
│   ├── common.nix           # Shared packages and configurations
│   ├── gui.nix              # GUI-specific packages (wezterm, sway)
│   ├── server.nix           # Server-specific packages and tools
│   └── macos.nix            # macOS-specific packages and settings
├── systems/
│   ├── macos.nix            # macOS system configuration
│   ├── nixos-desktop.nix    # NixOS desktop with GUI
│   └── nixos-server.nix     # NixOS headless server
└── users/
    └── lighthouse.nix       # User configuration
```

## Configurations

- **macOS**: Uses nix-darwin with wezterm terminal
- **NixOS Desktop**: Wayland + Sway window manager with GUI apps
- **NixOS Server**: Headless configuration with server tools

## Packages Included

### Common (all systems)
- vim, tmux, git, curl, wget
- Development tools: ripgrep, fd, bat, tree, htop
- SDKMAN and NVM (installed via activation scripts)

### GUI Systems
- wezterm (terminal emulator)
- Firefox, VS Code (NixOS desktop)
- Raycast, Rectangle, Stats (macOS)

### Server
- System monitoring: neofetch, nmap, tcpdump, iftop, iotop
- Security: fail2ban, openssh with key-only auth

## Usage

### Build macOS configuration:
```bash
nix run nix-darwin -- switch --flake .#macos
```

### Build NixOS desktop:
```bash
sudo nixos-rebuild switch --flake .#nixos-desktop
```

### Build NixOS server:
```bash
sudo nixos-rebuild switch --flake .#nixos-server
```

## Notes

- You'll need to create `hardware-configuration.nix` files for NixOS systems
- Update git user info in `modules/common.nix`
- Customize sway config in `modules/gui.nix` as needed