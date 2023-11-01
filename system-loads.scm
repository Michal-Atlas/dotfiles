(use-modules
 (atlas services btrbk)
 (atlas services morrowind)
 (atlas utils services)
 (gnu packages certs)
 (gnu packages linux)
 (gnu packages samba)
 (gnu services desktop)
 (gnu services)
 (gnu system file-systems)
 (gnu system linux-initrd)
 (gnu system mapped-devices)
 (gnu system pam)
 (gnu system setuid)
 (gnu system)
 (gnu)
 (guix gexp)
 (ice-9 curried-definitions)
 (ice-9 popen)
 (ice-9 textual-ports)
 (nongnu packages linux)
 (nongnu services vpn)
 (nongnu system linux-initrd))

(use-package-modules
 cups
 messaging
 wm
 gnome
 linux)

(use-service-modules
 admin
 base
 cuirass
 cups
 databases
 desktop
 file-sharing
 home
 linux
 messaging
 networking
 nix
 pm
 security
 shepherd
 sound
 ssh
 syncthing
 virtualization
 xorg
 vpn)
