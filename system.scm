(use-modules
 (atlas utils services)
 (gnu system file-systems)
 (gnu system mapped-devices)
 (gnu packages certs)
 (gnu packages linux)
 (gnu packages samba)
 (gnu system linux-initrd)
 (gnu system setuid)
 (gnu)
 (gnu system)
 (ice-9 popen)
 (ice-9 textual-ports)
 (nongnu packages linux)
 (nongnu system linux-initrd)
 (ice-9 curried-definitions))

(define (getlabel system)
  (chdir "/home/michal_atlas/cl/dotfiles/")
  (string-join
   (list
    (operating-system-default-label system)
    (string-trim-both
     (get-string-all
      (open-pipe* OPEN_READ
                  "git" "log" "-1" "--pretty=reference"))))
   " - "))

(operating-system
 (inherit (load (string-append "filesystems/" (gethostname) ".scm")))
 (host-name (gethostname))
 (kernel linux)
 (initrd microcode-initrd)
 (initrd-modules (cons "dm-raid" %base-initrd-modules))
 (label (getlabel this-operating-system))
 (locale "en_US.utf8")
 (timezone "Europe/Prague")
 (keyboard-layout
  (keyboard-layout "us,cz" ",ucw" #:options
                   '("grp:caps_switch" "grp_led"
                     "lv3:ralt_switch" "compose:rctrl-altgr")))
 (setuid-programs
  (append (list (setuid-program
                 (program (file-append cifs-utils "/sbin/mount.cifs"))))
          %setuid-programs))
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets `("/boot/efi"))))
 (packages %base-packages)
 (services (append
            (gather-services (string-append "system-" (gethostname)))
            (gather-services "system")))
 (name-service-switch %mdns-host-lookup-nss))
