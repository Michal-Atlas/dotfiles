(eval-when (expand load eval compile)
 (load "system-loads.scm"))

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

(define filesystems
  (load (string-append "filesystems/" (gethostname) ".scm")))

(define services
  (append
   (gather-services (string-append "system-" (gethostname)))
   (gather-services "system")))

(operating-system
 (inherit filesystems)
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
 (services services)
 (name-service-switch %mdns-host-lookup-nss))
