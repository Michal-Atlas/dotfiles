(define-library (system)
  (import (scheme base)
          (guile)
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
    (define (get-system host)
      (parameterize ((hostname host))
        (%system)))
    
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

    (define (%system)
      (operating-system
        (host-name (format #f "~a"
                           (keyword->symbol (hostname))))
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
        (packages (%packages))
        (firmware
         (@host
          linux-firmware
          #:hydra amdgpu-firmware))
        (locale "en_US.utf8")
        (timezone "Europe/Prague")
        (services (%services))
        (keyboard-layout
         (keyboard-layout "us,cz" ",ucw" #:options
		          '("grp:caps_switch" "grp_led"
		            "lv3:ralt_switch" "compose:rctrl-altgr")))
        (setuid-programs
         (append (list (setuid-program
		        (program (file-append cifs-utils "/sbin/mount.cifs"))))
	         %setuid-programs))
        (mapped-devices (%mapped-devices))
        (swap-devices (%swap))
        (file-systems (%filesystems))
        (bootloader
         (bootloader-configuration
          (bootloader grub-efi-bootloader)
          (targets `("/boot/efi"))))
        (name-service-switch %mdns-host-lookup-nss)))))
