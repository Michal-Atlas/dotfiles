## 0.6.0 (2024-06-13)

### Feat

- **pkgs**: Add coalton
- **guix**: Auto-import known profiles
- **users**: Add david
- Intern Leviathan

### Fix

- **pkgs**: Coalton is not yet upstreamed
- **syncthing**: Add leviathan
- **nix**: Nix -> Guix
- **nfs**: Separate mounts are required for nested filesystems

### Refactor

- Remove Guix

## 0.5.0 (2024-04-23)

### Feat

- **pkg**: Add racket
- **atlasnet**: Bring back + Wireguard
- **pkgs**: Add gitkraken
- **nextcloud**: Add matterbridge
- **secrets**: Add Nextcloud mount
- **ssh**: Add fray
- **nextcloud**: Add talks
- **hosts**: Yggdrasil access to nextcloud
- **kite**: Jellyfin https port
- **jellyfin**: Allow local
- **kite**: Add jellyfin
- **jellyfin**: Add
- **mount**: Add RouterDisk
- **kineto**: Add

### Fix

- **mounts**: Add webdav secret
- **hydra**: Remove router mount
- **nextcloud**: Open firewall port
- **mounts**: Centralize network mounts
- **spotifyd**: Remove user
- **pass**: Add otp

## 0.4.0 (2024-04-18)

### Feat

- **nextcloud**: Add
- **pkgs**: Add clang-tools
- **hosts**: Re-enable StevenBlackHosts
- **helix**: Add
- **scripts**: Added srun
- **hardware**: Add XBox controller support
- **zsh**: Allow comments

### Fix

- **zsh**: Use Emacs bindings
- **fonts**: Re-add fonts into system

## 0.3.0 (2024-03-31)

### Feat

- **hw**: Add xone driver
- **vim**: Add unison plugin
- **pkgs**: Add unison
- **spotifyd**: Move to home and auth
- **mail**: Set send format to plain
- **pkgs**: Allow insecure nix
- **fonts**: Add FiraMono and SourceCodePro, mv FiraCode to standalone
- **pkgs**: Add zathura, nodejs, acl, rlwrap
- **emacs**: org-mode: Use lualatex and js
- **pkgs**: Add lazygit
- **vim**: Set colorscheme to catppuccin
- **tmux**: Add
- **vim**: Add project, move to vim.nix
- **gnome**: Use kgx instead of neovide
- **vim**: Enable numbers
- **vim**: Enable tree-sitter, telescope and haskell-tools
- **gnome**: Remove obsolete keybinds!
- **vim**: Add magit
- **systemd**: Linger my user
- **vscode**: Remove!
- **nixvim**: Add a bunch of LSPs
- **gnome**: Switch dconf to neovide as editor
- **aliases**: Add lah
- **vim**: Add nixvim base
- **mail**: Add mail configuration to hm
- **eduroam**: Add eduroam setup
- **zfs**: Add separate mounts
- **podman**: Docker compatibility socket
- **zfs**: Legacy mounts
- **bignix**: Add alias
- **fs**: Btrfs -> ZFS!
- **zsh**: Extend zsh history to 100000
- **oracle**: Add system
- **pass**: Automatic sync
- **vscode**: Add a few settings
- **vsode**: Add settings, use as editor in gnome

### Fix

- **pkgs**: Remove some packages, remove fonts
- **flake**: Unpin emacs overlay
- **vim**: set autochdir
- **mail**: Set auth method, use flavour
- **firewall**: Let spotify through firewall
- **pkgs**: Mystic no longer in flake
- **vim**: Typo in number
- **vim**: Enable lsp
- **syncthing**: Update nox id
- **emacs**: Vastly reduce packages
- **zsh**: Correct bix alias
- **flatpak**: Remove sync script!
- **syncthing**: Update dagon id
- **flake**: Fix my overlay's url
- **dagon**: Battery issues
- **vscode**: Aliases don't apply to EDITOR
- **vscode**: Fix shortcuts
- **wallpaper**: Switch day wallpaper to ship and zoom night
- **ipfs**: Remove forgotten package and mount
- **home/firefox**: Fix browserpass
- **registry**: Allow global registry, remove nix-index

## 0.2.0 (2024-03-07)

### Feat

- **home/packages**: Add HLS and RNIX
- **home/packages**: Add packages
- **home**: Add vscode
- **home/programs**: Set EDITOR to vscodium
- **fit-mount**: Fit-mount with OpenVPN client and automount

### Fix

- **zsh**: Update syntax highlighting option name
- **ipfs**: Remove IPFS!
- **hydra/filesystems.nix**: Use library btrfsMount instead of local

## 0.1.0 (2024-03-05)

### Feat

- **commit**: Add commit command

### Fix

- **flake.nix**: Use whole commitizen package

## 0.0.2 (2024-03-05)
