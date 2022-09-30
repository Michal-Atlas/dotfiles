(define-module (atlas system nanosys)
  #:use-module (gnu)
  #:use-module (gnu packages))

(use-package-modules
 text-editors
 shells
 hurd
 emacs
 linux)

(define-public %nano-system
  (operating-system
   (host-name "NanoSys")
   (kernel gnumach)
   (hurd hurd)
   (locale "en_US.utf8")
   (timezone "Europe/Prague")
   (keyboard-layout
    (keyboard-layout "us,cz" ",qwerty" #:options '("grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr")))
   (users (cons* (user-account
		  (name "michal_atlas")
		  (group "users")
		  (password (crypt "12345678" "salt"))
		  (supplementary-groups
		   '("netdev" "audio" "video")))
		 %base-user-accounts))
   (packages
    (cons
     emacs
     %base-packages))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets `("/boot/efi"))))
   (file-systems %base-file-systems)
   (name-service-switch %mdns-host-lookup-nss)))

%nano-system
