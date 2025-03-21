## 0.29.0 (2025-03-15)

### Feat

- **firefox**: Remove zotero
- **unison**: Remove
- **hyprland**: Lower screen timeout
- **hydra/fileSystems**: Finalize root, remove BTRFS

## 0.28.0 (2025-03-08)

### Feat

- **hydra/fileSystems**: to ZFS
- **firefox**: Remove old-reddit-redirect
- **zfs**: Move to desktop
- **filesystems**: For god's sake run scrubs
- **firefox**: Remove accumulate
- **bat**: Leave out numbers

## 0.27.0 (2025-03-01)

### Feat

- **pkgs**: Add mtp
- **flake**: Update
- **vim**: Don't install GHC with nixvim
- **vim**: Remove Haskell Scope Highlighting

### Fix

- **flake**: WWW from remote

## 0.26.0 (2025-02-24)

### Feat

- **wallpaper**: Negate
- **zsh**: I can't do this, for now
- **hyprland**: Add notification history button
- **hyprland**: A bunch of tray stuff
- **lf**: Customize preview and basic options
- **hyprland**: Swap to activation with greetd
- **wallpaper**: Temporarily set the vi cheatsheet
- **zsh**: Try using vi mappings
- **hosts**: Disable StevenBlack
- **vi**: Add plugins
- **vi**: Disable formatting for TeX
- **papis**: Replace Zotero
- **pkgs**: Add calibre
- **vim**: Tweaks, many of them
- **pkgs**: Add lf and ripgrep
- **vim**: Move plugins to desktop
- **hm**: Allow overwriting files
- **term**: Move to desktop
- **pkgs**: Remove invokeai
- **hosts**: Remove social from StevenBlack
- **vpsFree**: Add disabled Terraria server
- **ssh**: Use mosh for when the laptop closes
- **pkgs**: Remove zathura
- **vpsFree**: AutoGC
- **blog**: Fix favicon
- **gemini/ipfs**: Add gateway
- **hyprlock**: Remove random laptop thing
- **cachix**: Remove
- **stevenblackhosts**: Block all
- **nix**: Move ssh-serve to general
- **hyprland**: Remove locking for now
- **hosts**: Add vorpal yggdrasil address
- **ipfs**: Seems dnsaddr doesn't resolve
- **vpsFree/ipfs**: Disable RelayClient
- **fail2ban**: Add
- **vpsFree/kubo**: Close off public addresses due to DOS
- **pkgs**: Remove okular
- **i18n**: Remove the inputmethod temporarily
- **gpg**: Fix after removing GNOME features
- **locate**: Add
- **pkgs**: Remove nautilus
- **git**: Enable LFS
- **hyprland**: Start manually and with systemd
- **users**: Linger

### Fix

- **nginx**: Remove old setup
- **pkgs**: Remove python from python?
- **ssh**: mosh misinterpreted flags
- **flake**: Reference basic homeManagerModules in desktop
- **nginx**: Favicon on blog
- **editor**: Switch from Helix and Emacs to Vim orientation
- **hyprland**: Fix light increments
- **hyprland**: Correct lock program
- **autologin**: How??
- **hyprland**: Startup should be after all else is loaded
- **locate**: Explicitly unset localuser
- **secrets**: Rekey for Hydra

## 0.25.0 (2025-02-08)

### Feat

- **ssh**: Reattach same tmux session
- **nm-applet**: Add
- **ctu**: Readd VPN and Mount
- **firefox**: Remove untrap-yt
- **beesd**: Enable
- **ipfs**: Goodbye for now
- **pkgs**: Add diffoscope

## 0.24.0 (2025-02-01)

### Feat

- **vpsFree/mastodon**: Remove
- **hydra**: Reduce snapshot storage
- **firefox**: Disable extension blocking
- **firefox**: Try getting extensions to update
- **firefox**: Add query_amo extension
- **avahi**: Add
- **git**: autoStash
- **hyprland**: Only have workspaces on one monitor

## 0.23.0 (2025-01-25)

### Feat

- **firefox**: Readd simple-translate
- **hyprland**: Only lock laptops
- **social**: Transitive Mastodon -> Gotosocial
- **firefox**: Add language learning extensions
- **hyprland**: Add additional input methods for Jap and Ru
- **stylix**: Monokai
- **pkgs**: Add whisper
- **pkgs**: Add gnugo
- **ipfs**: Reenable
- **nix**: Ocassionally run optimise as well
- **nix**: Remove channels completely
- **vpsFree**: Add drive nginx
- **vpsFree**: Remove obsolete stuff
- **flake**: Update lock removing pic-a-day
- **nix**: Allow Git fetches in restricted mode
- **flake**: Add hydraJobs for nixosConfigurations
- **pkgs**: Add pulsemixer
- **btrbk**: Don't preserve past a year
- **pkgs**: Add hyperfine
- **ssh**: Use keybind to open tmux ssh session terminals
- **btrbk**: Reduce min preserve time
- **invokeai**: Add

### Fix

- **ipfs**: Apparently wrapping the whole thing in default breaks
- **ipfs**: Disable autoMount
- **nix**: Remove allowed-uris
- **dconf**: Remove forgotten hydra config
- **hydra**: scrap
- **flake**: Lock nixified
- **tmux**: Open with alias, RemoteCommand breaks things

## 0.22.0 (2025-01-18)

### Feat

- **ipfs/vpsFree**: Reduce config
- **pkgs**: Add bluetuith
- **pkgs**: Add sniffnet
- **pkgs**: Add wl-mirror
- **gdm**: Use for startup
- **pkgs**: Add libnotify

### Fix

- **hyprland**: Bring closer to Sway behaviour
- **waybar**: Start with default target
- **hyprland**: Place screenshots in folder

## 0.21.0 (2025-01-11)

### Feat

- **hyprland**: Remove gaps and therefore fancy wallpaper
- **stylix**: Don't use grub
- **hyprland**: Use wpaperd instead of hyprpaper for switching
- **hyprland**: Inherit env
- **pkgs**: Keep nautilus
- **polkit**: NOPASSWD
- **soteria**: Add
- **wlsunset**: Add
- **waybar**: Margins are necessary
- **otd**: Add
- **zsh**: Add auto-notify
- **pkgs**: Add snapshot
- **hyprland**: Enable screenshots
- **xdg**: Enable icons something???
- **pkgs**: Add wdisplays
- **fonts**: Use Jetbrains Mono for sansSerif
- **waybar**: Styling
- **gamemode**: Add
- **hydra/filesystems**: Place root on SSD
- **hyprland**: Use instead of Gnome
- **pkgs**: Add ipscan

### Fix

- **wpaperd**: Correct duration
- **hyprland**: factor out iteration
- **gtk**: Declare icon theme
- **waybar**: Margins and charging
- **pkgs**: Rustup was in wrong section
- **hydra/monitors**: Place on right
- **bootstrap-eduroam**: Script hash changed again
- **hyprland**: Startup issues
- **flake**: Reorganize modules to separate out desktop features

## 0.20.0 (2025-01-06)

### Feat

- **bees**: Configure with smaller table and lower load

### Fix

- **stylix**: Lock to current release

## 0.19.0 (2025-01-04)

### Feat

- **ipfs**: Remove
- **bees**: Add on hydra
- **spotifyd**: Use high bitrate
- **pkgs**: Add Usbutils
- **pkgs**: Add github CLI

### Fix

- **firewall**: Fix chromecast connection
- **ci**: Format
- **tmux**: Don't open in all shells, bad idea

## 0.18.0 (2025-01-04)

### Feat

- **networking**: Remove nameservers
- **stylix**: Set color scheme to gruvbox
- **gemini**: molly-brown -> stargazer
- **firefox**: Use native vertical tabs
- **blog**: Use my own css
- **blog**: Use flake input for www repo
- **pkgs**: Add rustup
- **firefox**: Remove substitoot
- **term**: Use pipe symbol
- **nix**: Optimise live
- **spotify**: Replace spicetify with spotify-player

### Fix

- **mastodon**: Remove
- **vpsFree**: Remove socials since they're on blog
- **flake**: Remove spicetify from lock

## 0.17.0 (2024-12-28)

### Feat

- **shell**: SSH in new terminal window
- **ipfs**: Allow Filestore
- **stylix**: Add
- **tmux**: Use alacritty+tmux as TERM
- **hosts**: Use upstream Steven Black
- **checks**: pre-commit treefmt
- **yggdrasil/vpsFree**: Allow IPv6 directs
- **users**: Widen subUid ranges
- **peertube**: Remove
- **vnstat**: Add
- **rss**: Use gnome-feeds

### Fix

- **vpsFree/ipfs**: Memory limit

## 0.16.0 (2024-12-21)

### Feat

- **write.as**: Add
- **mastodon**: Disable for now
- **pixelfed**: Add
- **flake**: Reorganize to follow option structure
- **fediverse**: Add
- **pkgs**: Move bootstrap-eduroam to permanent packages
- **flake**: Add set -x in devShell scripts
- **srht**: Almost works, DKIM is dodgy
- **mail**: Enable protonmail bridge
- **nginx**: Use recommended Optimisation
- **flake**: Use treefmt-nix
- **lock**: Added gemini
- **pkgs**: Add GoLand and Xournalpp
- **hydra/tftp**: Add
- **registry**: Allow self
- **vorpal**: Add Blog servers for Gemini and HTTP
- **ipfs**: Gateway enable IPv6
- **nginx**: remove from hydra
- **nginx**: Enable recommended settings globally
- **pkgs**: Add webstorm
- **tftpd**: Add on hydra
- **vorpal**: Enable reprovide
- **cz**: Autobump
- **ipfs**: Start chaining
- **kdeConnect**: Add
- **flake**: Update
- **flake**: Update
- **book-dagon**: First attempt at setup
- **ipfs**: Listen on IP
- **nix-diff**: Reduce context
- **vorpal**: Actually enable nginx
- **vpsFree**: Rename to vorpal
- **ipfs**: Disable on vorpal
- **ipfs**: Enable
- **nginx**: Move to vorpal
- **guix**: Remove
- **vpsFree**: Disable Emacs and Dconf
- **atlasnet**: Start building new scheme
- **emacs**: Make package overrideable
- **pkgs**: Add multipath-tools
- **registry**: Move to system
- **vpsFree**: Use hm without packages
- **user**: Add to dialout group
- **term**: Infinite scrollback, default font
- **tailscale**: Remove
- **gnome**: Update extensions
- **pkgs**: Add dust, bmaptool and sshfs
- **vpsFree**: Add
- **oracle**: Add
- **nginx**: Serve gallery
- **sudo**: NOPASSWD
- **firefox**: Add options search
- **firefox**: More declarations
- **postgres**: Add
- **firefox**: Declare policies and addons
- **ipfs**: Move to networking don't enable yet
- **btrbk**: Add on hydra
- **filesystems**: hydra add global raw mounts
- **zfs**: Deprecated linux kernel
- **tailscale**: Add
- **nixpkgs**: allowUnfree in config
- **gnome**: Use up-to-date pano
- **pkgs**: Remove Brave
- **mosh**: Add
- **htop**: Add config
- **amdgpu**: Start using 24.11 features
- **hydra**: Filesystems
- **leviathan**: Filesystems
- **java**: Add and binfmt
- **pkgs**: Add Onedrive
- **pkgs**: Add python features
- **flake**: Update
- **users**: Set UIDs explicitly so they can be referenced
- **pkgs**: Add chez and RustRover
- **flake**: Update
- **pkgs**: Add ecl and abcl
- **services**: Try autostarting all often used apps
- **pkgs**: Add rclone
- **nix**: Verbose logs
- **protonmail**: Add service for GUI
- **pkgs**: Add protonmail GUI
- **flake**: Update
- **pkgs**: Add IDEA
- **flake**: Update
- **pkgs**: Add packages
- **flake**: Update
- **vpn**: Swapping wg-quick for app
- **dns**: Add CZ.NIC IPv6
- **dns**: Enable DNSSec
- **ipfs**: Really remove

### Fix

- **nginx**: Increase max body size
- **oracle**: Remove
- **nixos-flake**: Repo was renamed
- **flake**: ci
- **ipfs**: Merge attrsets
- **pkgs**: Move these packages to their own project's repo
- **vpsFree**: extraConfig duplicated headers
- **check**: Use emacs-nox
- **bookDagon**: Don't proxy IPFS over self
- **flake**: Make stuff overridable options
- **vpsFree**: Accidentally overrode all packages to empty
- **atlasnet**: Separate IP versions and listen
- **mail**: Remove old protonmail units
- **firefox**: Typo in userChrome
- **nftables**: Stuff presumes iptables
- **flake**: Remove self from registry, FOR NOW
- **syncthing**: Run with users group
- **pkgs**: gnome-setting-daemon is now toplevel
- **git-sync**: Deprecated
- **pkgs**: Polari is now toplevel
- **xdg**: Use portals
- **secrets**: Cleanup, rethink
- **syncthing**: Update leviathan key
- **ipfs**: Disable ADHTC
- **eduroam**: Update hash
- **gnome**: Move extensions to their option
- **secrets**: Update CTU
- **nixos-flake**: Update fixup
- **services**: Remove random startup stuff
- **protonmail**: Use valid target for bridge
- **flake**: nixos-flake added home-manager option
- **mail**: Install.After is invalid?

## 0.14.0 (2024-09-09)

### Feat

- **syncthing**: Add windows
- **hydra**: Don't lock
- **flake**: Update
- **ipfs**: Tweak around
- **protonvpn**: Move to wireguard
- **pkgs**: Add nethogs
- **yggdrasil**: Properly name interface
- **nix**: Clear history more often
- **vpn**: Add ad-hoc protonvpn to hydra
- **dconf**: Add Brave to bar
- **ipfs**: Use accelerated dht on Hydra
- **ipfs**: Set Standard HighWater on Hydra
- **ipfs**: Remove cluster
- **keys**: Add biometric
- **pkgs**: Add protonvpn and brave
- **emacs**: Add unison mode
- **ipfs**: Remove
- **emacs**: Add elm-mode
- **pass**: Remove browserpass
- **flake**: Update
- **flake**: Update
- **mail**: Add protonmail
- **ipfs**: Disable cluster
- **flake**: Add np flake to more easily access up-to-date nonFree
- **ipfs**: Hydra as Node, rest as Clients
- **syncthing**: Raise send limit
- **ipfs**: Set correct target for cluster
- **flake**: Update weekly
- **gh**: Remove
- **flake**: Lock emacs-overlay in place
- **repo**: link Changelog as readme
- **flake**: Update
- **nix**: Capitulate on allowUnfree
- **gh**: Add

### Fix

- **secrets**: Accidentally used old key
- **dconf**: Idle delay needs type annotation
- **flake**: Use nixfmt-rfc directly
- **nix-gc**: Remove from laptop configured globally
- **network**: Disable wait-online
- **drivers**: Move amdgpu to hydra only
- **nixpkgs**: Wrong config
- **fmt**: Reformat to RFC-style
- **fmt**: dconf and secrets

## 0.13.0 (2024-08-20)

### Feat

- **flake**: Add YAML linter
- **nix**: Automate long-term GC
- **flake**: Use module for NixOS
- **guix**: GC fully
- **flake**: flake-checker
- **flake**: Add GitHub autobump
- **syncthing**: Only limit upload on hydra
- **flake**: Format to nixfmt instead of alejandra
- **syncthing**: Add gandr

### Fix

- **ci**: Correct typo
- **flake**: Remove flake-checker
- **emacs**: Format

## 0.12.0 (2024-08-17)

### Feat

- **pkgs**: Add gmic
- **flake**: Update
- **ipfs**: Only use QUIC transport
- **pkgs**: Add prefetch and nurl
- **networking**: Try to rate limit
- **ipfs**: Prettier cluster unit
- **pkgs**: Add nixfmt
- **torrents**: Swap to qbittorrent
- **dconf**: Automated time switching
- **ipfs**: Test cluster
- **flake**: Update
- **ipfs**: Give up on NATing, publish Yggdrasil
- **pkgs**: Add xml tools
- **ipfs**: Open UDP
- **ipfs**: Add
- **bignix**: Remove
- **pano**: Quiet
- **spotifyd**: Unauthenticated and only on hydra
- **flake**: Update

### Fix

- **bluetooth**: Typo
- **ipfs**: Open port and add group
- **pano**: Update to 23 alpha
- **spotifyd**: No autoplay
- **firewall**: Move spotify ports to hydra
- **hosts**: Don't block youtube
- **hosts**: Do not block social

## 0.11.0 (2024-07-23)

### Feat

- **emacs**: Enter shortcut
- **emacs**: Reinstate as primary editor
- **firefox**: Configure with hm
- **hosts**: Enable black
- **pkgs**: Add GNOME utils
- **flake**: Update
- **pkgs**: Add former flatpaks
- **gnome**: Set baselines

### Fix

- **files**: Remove old files
- **checks**: Fix pre-commit hook

## 0.10.0 (2024-07-13)

### Feat

- **gnome**: Don't sleep on battery
- **secrets**: Update leviathan keys
- **syncthing**: Update leviathan keys
- **leviathan**: Only use 2 datapools
- **memtest**: Add
- **checks**: Use flake module
- **pkgs**: Add cachix
- **pkgs**: Add ani-cli
- **flake**: Update
- **pkgs**: Add nix-diff
- **keys**: Update arc
- **syncthing**: Sync Music
- **pkgs**: Swap some basic things for Canonical
- **kdeconnect**: Disable
- **pkgs**: cleanup
- **torrents**: Remove global transmission daemon
- **nix-index**: Use Database

### Fix

- **hydra**: Typo
- **opengl**: Move amd stuff to hydra
- **keys**: Why are these here?

## 0.9.0 (2024-07-06)

### Feat

- **flake**: Update
- **zsh**: Complete aliases

### Fix

- **flake**: Remove obsolete flake input
- **nom**: Not a complete drop-in sadly
- **devShell**: Keep recdiff

## 0.8.0 (2024-07-06)

### Feat

- **pkgs**: Add practical nix utils
- **devShell**: Use nh for recon
- **checks**: Finally enable statix again
- **nix-index**: Add
- **tmp**: Keep tmp for 5d
- **gnome**: Clean extensions, integrate spotify and pano
- **gnome**: Cleanup extensions add mpris
- **spotifyd**: Enable locally at least
- **pkgs**: Add more Wine
- **pkgs**: Add from profile
- **laptop**: Enable rotation sensor
- **pkgs**: Add whatsapp
- **font**: Set font for console

### Fix

- **checks**: Fix statix
- **secrets**: Update CTU password
- **secrets**: Fix leviathan yggdrasil
- **fmt**: Format leviathan
- **pre-commit**: Remove pre-commit from vc

## 0.7.1 (2024-06-24)

### Fix

- **secrets**: Fix fit-vpn
- **secrets**: Fix fit-mount
- **repo**: Remove pre-inst-env
- **hydra**: Remove dead code
- **secrets**: Remove unused secrets

## 0.7.0 (2024-06-24)

### Feat

- **syncthing**: Sync around Pictures
- **laptop**: Use specific nixos-hardware for each
- **secrets**: Update secrets to know Leviathan
- **fonts**: Add defaults

### Fix

- **files**: Remove Guix home files copy
- **syncthing**: Update Leviathan ID
- **flatpak**: Remove sync script
- **guix**: Delete packages file
- **flake**: Rename deprecated options
- **yggdrasil**: Actually allow peering
- **kineto**: Remove
- **pkgs**: remove pinentry-curses
- **net**: Update leviathan keys

### Perf

- **flake**: Remove unused inputs
- **morrowind**: Disable tes3mp for now

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

## 0.15.0 (2024-12-15)

### Feat

- **srht**: Almost works, DKIM is dodgy
- **mail**: Enable protonmail bridge
- **nginx**: Use recommended Optimisation
- **flake**: Use treefmt-nix
- **lock**: Added gemini
- **pkgs**: Add GoLand and Xournalpp
- **hydra/tftp**: Add
- **registry**: Allow self
- **vorpal**: Add Blog servers for Gemini and HTTP
- **ipfs**: Gateway enable IPv6
- **nginx**: remove from hydra
- **nginx**: Enable recommended settings globally
- **pkgs**: Add webstorm
- **tftpd**: Add on hydra
- **vorpal**: Enable reprovide
- **cz**: Autobump
- **ipfs**: Start chaining
- **kdeConnect**: Add
- **flake**: Update
- **flake**: Update
- **book-dagon**: First attempt at setup
- **ipfs**: Listen on IP
- **nix-diff**: Reduce context
- **vorpal**: Actually enable nginx
- **vpsFree**: Rename to vorpal
- **ipfs**: Disable on vorpal
- **ipfs**: Enable
- **nginx**: Move to vorpal
- **guix**: Remove
- **vpsFree**: Disable Emacs and Dconf
- **atlasnet**: Start building new scheme
- **emacs**: Make package overrideable
- **pkgs**: Add multipath-tools
- **registry**: Move to system
- **vpsFree**: Use hm without packages
- **user**: Add to dialout group
- **term**: Infinite scrollback, default font
- **tailscale**: Remove
- **gnome**: Update extensions
- **pkgs**: Add dust, bmaptool and sshfs
- **vpsFree**: Add
- **oracle**: Add
- **nginx**: Serve gallery
- **sudo**: NOPASSWD
- **firefox**: Add options search
- **firefox**: More declarations
- **postgres**: Add
- **firefox**: Declare policies and addons
- **ipfs**: Move to networking don't enable yet
- **btrbk**: Add on hydra
- **filesystems**: hydra add global raw mounts
- **zfs**: Deprecated linux kernel
- **tailscale**: Add
- **nixpkgs**: allowUnfree in config
- **gnome**: Use up-to-date pano
- **pkgs**: Remove Brave
- **mosh**: Add
- **htop**: Add config
- **amdgpu**: Start using 24.11 features
- **hydra**: Filesystems
- **leviathan**: Filesystems
- **java**: Add and binfmt
- **pkgs**: Add Onedrive
- **pkgs**: Add python features
- **flake**: Update
- **users**: Set UIDs explicitly so they can be referenced
- **pkgs**: Add chez and RustRover
- **flake**: Update
- **pkgs**: Add ecl and abcl
- **services**: Try autostarting all often used apps
- **pkgs**: Add rclone
- **nix**: Verbose logs
- **protonmail**: Add service for GUI
- **pkgs**: Add protonmail GUI
- **flake**: Update
- **pkgs**: Add IDEA
- **flake**: Update
- **pkgs**: Add packages
- **flake**: Update
- **vpn**: Swapping wg-quick for app
- **dns**: Add CZ.NIC IPv6
- **dns**: Enable DNSSec
- **ipfs**: Really remove

### Fix

- **flake**: ci
- **ipfs**: Merge attrsets
- **pkgs**: Move these packages to their own project's repo
- **vpsFree**: extraConfig duplicated headers
- **check**: Use emacs-nox
- **bookDagon**: Don't proxy IPFS over self
- **flake**: Make stuff overridable options
- **vpsFree**: Accidentally overrode all packages to empty
- **atlasnet**: Separate IP versions and listen
- **mail**: Remove old protonmail units
- **firefox**: Typo in userChrome
- **nftables**: Stuff presumes iptables
- **flake**: Remove self from registry, FOR NOW
- **syncthing**: Run with users group
- **pkgs**: gnome-setting-daemon is now toplevel
- **git-sync**: Deprecated
- **pkgs**: Polari is now toplevel
- **xdg**: Use portals
- **secrets**: Cleanup, rethink
- **syncthing**: Update leviathan key
- **ipfs**: Disable ADHTC
- **eduroam**: Update hash
- **gnome**: Move extensions to their option
- **secrets**: Update CTU
- **nixos-flake**: Update fixup
- **services**: Remove random startup stuff
- **protonmail**: Use valid target for bridge
- **flake**: nixos-flake added home-manager option
- **mail**: Install.After is invalid?

## 0.14.0 (2024-09-09)

### Feat

- **syncthing**: Add windows
- **hydra**: Don't lock
- **flake**: Update
- **ipfs**: Tweak around
- **protonvpn**: Move to wireguard
- **pkgs**: Add nethogs
- **yggdrasil**: Properly name interface
- **nix**: Clear history more often
- **vpn**: Add ad-hoc protonvpn to hydra
- **dconf**: Add Brave to bar
- **ipfs**: Use accelerated dht on Hydra
- **ipfs**: Set Standard HighWater on Hydra
- **ipfs**: Remove cluster
- **keys**: Add biometric
- **pkgs**: Add protonvpn and brave
- **emacs**: Add unison mode
- **ipfs**: Remove
- **emacs**: Add elm-mode
- **pass**: Remove browserpass
- **flake**: Update
- **flake**: Update
- **mail**: Add protonmail
- **ipfs**: Disable cluster
- **flake**: Add np flake to more easily access up-to-date nonFree
- **ipfs**: Hydra as Node, rest as Clients
- **syncthing**: Raise send limit
- **ipfs**: Set correct target for cluster
- **flake**: Update weekly
- **gh**: Remove
- **flake**: Lock emacs-overlay in place
- **repo**: link Changelog as readme
- **flake**: Update
- **nix**: Capitulate on allowUnfree
- **gh**: Add

### Fix

- **secrets**: Accidentally used old key
- **dconf**: Idle delay needs type annotation
- **flake**: Use nixfmt-rfc directly
- **nix-gc**: Remove from laptop configured globally
- **network**: Disable wait-online
- **drivers**: Move amdgpu to hydra only
- **nixpkgs**: Wrong config
- **fmt**: Reformat to RFC-style
- **fmt**: dconf and secrets

## 0.13.0 (2024-08-20)

### Feat

- **flake**: Add YAML linter
- **nix**: Automate long-term GC
- **flake**: Use module for NixOS
- **guix**: GC fully
- **flake**: flake-checker
- **flake**: Add GitHub autobump
- **syncthing**: Only limit upload on hydra
- **flake**: Format to nixfmt instead of alejandra
- **syncthing**: Add gandr

### Fix

- **ci**: Correct typo
- **flake**: Remove flake-checker
- **emacs**: Format

## 0.12.0 (2024-08-17)

### Feat

- **pkgs**: Add gmic
- **flake**: Update
- **ipfs**: Only use QUIC transport
- **pkgs**: Add prefetch and nurl
- **networking**: Try to rate limit
- **ipfs**: Prettier cluster unit
- **pkgs**: Add nixfmt
- **torrents**: Swap to qbittorrent
- **dconf**: Automated time switching
- **ipfs**: Test cluster
- **flake**: Update
- **ipfs**: Give up on NATing, publish Yggdrasil
- **pkgs**: Add xml tools
- **ipfs**: Open UDP
- **ipfs**: Add
- **bignix**: Remove
- **pano**: Quiet
- **spotifyd**: Unauthenticated and only on hydra
- **flake**: Update

### Fix

- **bluetooth**: Typo
- **ipfs**: Open port and add group
- **pano**: Update to 23 alpha
- **spotifyd**: No autoplay
- **firewall**: Move spotify ports to hydra
- **hosts**: Don't block youtube
- **hosts**: Do not block social

## 0.11.0 (2024-07-23)

### Feat

- **emacs**: Enter shortcut
- **emacs**: Reinstate as primary editor
- **firefox**: Configure with hm
- **hosts**: Enable black
- **pkgs**: Add GNOME utils
- **flake**: Update
- **pkgs**: Add former flatpaks
- **gnome**: Set baselines

### Fix

- **files**: Remove old files
- **checks**: Fix pre-commit hook

## 0.10.0 (2024-07-13)

### Feat

- **gnome**: Don't sleep on battery
- **secrets**: Update leviathan keys
- **syncthing**: Update leviathan keys
- **leviathan**: Only use 2 datapools
- **memtest**: Add
- **checks**: Use flake module
- **pkgs**: Add cachix
- **pkgs**: Add ani-cli
- **flake**: Update
- **pkgs**: Add nix-diff
- **keys**: Update arc
- **syncthing**: Sync Music
- **pkgs**: Swap some basic things for Canonical
- **kdeconnect**: Disable
- **pkgs**: cleanup
- **torrents**: Remove global transmission daemon
- **nix-index**: Use Database

### Fix

- **hydra**: Typo
- **opengl**: Move amd stuff to hydra
- **keys**: Why are these here?

## 0.9.0 (2024-07-06)

### Feat

- **flake**: Update
- **zsh**: Complete aliases

### Fix

- **flake**: Remove obsolete flake input
- **nom**: Not a complete drop-in sadly
- **devShell**: Keep recdiff

## 0.8.0 (2024-07-06)

### Feat

- **pkgs**: Add practical nix utils
- **devShell**: Use nh for recon
- **checks**: Finally enable statix again
- **nix-index**: Add
- **tmp**: Keep tmp for 5d
- **gnome**: Clean extensions, integrate spotify and pano
- **gnome**: Cleanup extensions add mpris
- **spotifyd**: Enable locally at least
- **pkgs**: Add more Wine
- **pkgs**: Add from profile
- **laptop**: Enable rotation sensor
- **pkgs**: Add whatsapp
- **font**: Set font for console

### Fix

- **checks**: Fix statix
- **secrets**: Update CTU password
- **secrets**: Fix leviathan yggdrasil
- **fmt**: Format leviathan
- **pre-commit**: Remove pre-commit from vc

## 0.7.1 (2024-06-24)

### Fix

- **secrets**: Fix fit-vpn
- **secrets**: Fix fit-mount
- **repo**: Remove pre-inst-env
- **hydra**: Remove dead code
- **secrets**: Remove unused secrets

## 0.7.0 (2024-06-24)

### Feat

- **syncthing**: Sync around Pictures
- **laptop**: Use specific nixos-hardware for each
- **secrets**: Update secrets to know Leviathan
- **fonts**: Add defaults

### Fix

- **files**: Remove Guix home files copy
- **syncthing**: Update Leviathan ID
- **flatpak**: Remove sync script
- **guix**: Delete packages file
- **flake**: Rename deprecated options
- **yggdrasil**: Actually allow peering
- **kineto**: Remove
- **pkgs**: remove pinentry-curses
- **net**: Update leviathan keys

### Perf

- **flake**: Remove unused inputs
- **morrowind**: Disable tes3mp for now

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
