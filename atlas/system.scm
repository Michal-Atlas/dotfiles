(define-module (atlas system)
  #:use-module (srfi srfi-98)
  #:use-module (ice-9 textual-ports)
  #:use-module (ice-9 popen)
  #:use-module (atlas utils combinators)
  #:use-module ((atlas utils services) #:select (@host))
  #:use-module (nongnu packages linux)
  #:use-module (gnu packages samba)
  #:use-module (nongnu system linux-initrd)
  #:use-module (atlas system packages)
  #:use-module (atlas system services)
  #:use-module (atlas system filesystems mapped)
  #:use-module (atlas system filesystems)
  #:use-module (atlas system filesystems swap)
  #:use-module (gnu system setuid)
  #:use-module (gnu))

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

(define (get-system host)
  (->
   (operating-system
    (host-name host)
    (kernel linux)
    (initrd microcode-initrd)
    (label (getlabel this-operating-system))
    (firmware
     (@host host
            linux-firmware
            #:hydra amdgpu-firmware))
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
    (file-systems %base-file-systems)
    (packages %base-packages)
    (services '())
    (name-service-switch %mdns-host-lookup-nss))
   %packages
   %services
   %mapped-devices
   %swap
   %filesystems
   (users
    (user-account
     (name "michal_atlas")
     (comment "Michal Atlas")
     (group "users")
     (home-directory "/home/michal_atlas")
     (supplementary-groups
      '("wheel" "netdev" "audio" "docker"
        "video" "libvirt" "kvm" "tty" "transmission"))))))

(get-system (gethostname))
