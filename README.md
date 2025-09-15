# NixOS Configuration

This repository contains NixOS configurations for both desktop and headless server systems.

## Structure

```
flake.nix                 # Main flake configuration
modules/
├── common.nix           # Shared packages and configurations
├── gui.nix              # GUI-specific packages (wezterm, sway)
└── server.nix           # Server-specific packages and tools
systems/
├── nixos-desktop.nix    # NixOS desktop with GUI
└── nixos-server.nix     # NixOS headless server
users/
└── gh.nix               # User configuration
```

## Configurations

- **NixOS Desktop**: Wayland + Sway window manager with GUI apps
- **NixOS Server**: Headless configuration with server tools

## Packages Included

### Common (all systems)
- vim, tmux, git, curl, wget
- Development tools: ripgrep, fd, bat, tree, htop
- SDKMAN and NVM (installed via activation scripts)

### GUI Systems
- wezterm (terminal emulator)
- Firefox, VS Code

### Server
- System monitoring: neofetch, nmap, tcpdump, iftop, iotop
- Security: fail2ban, openssh with key-only auth

## Usage

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
