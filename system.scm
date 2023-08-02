(define-library (system)
  (import (guile)
          (srfi srfi-98)
          (ice-9 textual-ports)
          (ice-9 popen)
          (utils services)
          (nongnu packages linux)
          (gnu packages samba)
          (nongnu system linux-initrd)
          (system packages)
          (system services)
          (system filesystems mapped)
          (system filesystems)
          (system filesystems swap)
          (gnu system setuid)
          (gnu))
  (export get-system)
  (begin
    (define (getlabel system)
      (chdir (dirname (current-filename)))
      (string-join
       (list
        (operating-system-default-label system)
        (string-trim-both
         (get-string-all
          (open-pipe* OPEN_READ
                      "git" "log" "-1" "--pretty=%B"))))
       " - "))

    (define (get-system host)
      (operating-system
        (host-name host)
        (kernel linux)
        (initrd microcode-initrd)
        (label (getlabel this-operating-system))
        (users (list (user-account
	              (name "michal_atlas")
	              (comment "Michal Atlas")
	              (group "users")
	              (home-directory "/home/michal_atlas")
	              (supplementary-groups
	               '("wheel" "netdev" "audio" "docker"
	                 "video" "libvirt" "kvm" "tty" "transmission")))))
        (packages %packages)
        (firmware
         (@host host
          linux-firmware
          #:hydra amdgpu-firmware))
        (locale "en_US.utf8")
        (timezone "Europe/Prague")
        (services (%services host))
        (keyboard-layout
         (keyboard-layout "us,cz" ",ucw" #:options
		          '("grp:caps_switch" "grp_led"
		            "lv3:ralt_switch" "compose:rctrl-altgr")))
        (setuid-programs
         (append (list (setuid-program
		        (program (file-append cifs-utils "/sbin/mount.cifs"))))
	         %setuid-programs))
        (mapped-devices (%mapped-devices host))
        (swap-devices (%swap host))
        (file-systems (%filesystems host))
        (bootloader
         (bootloader-configuration
          (bootloader grub-efi-bootloader)
          (targets `("/boot/efi"))))
        (name-service-switch %mdns-host-lookup-nss)))

    (get-system (vector-ref (uname) 1))))
