(define-module (atlas system nanosys)
  #:use-module (gnu)
  #:use-module (gnu packages))

(use-package-modules
 text-editors
 shells
 emacs
 linux)

(define-public %nano-system
  (operating-system
   (host-name "Progtest")
   (kernel linux-libre)
   (locale "en_US.utf8")
   (timezone "Europe/Prague")
   (keyboard-layout
    (keyboard-layout "us,cz" ",qwerty" #:options '("grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr")))
   (users (cons* (user-account
		  (name "progtest")
		  (comment "Progtest")
		  (group "users")
		  (password (crypt "progtest" "salt"))
		  (shell (file-append (specification->package "bash") "/bin/bash"))
		  (supplementary-groups
		   '("netdev" "audio" "video")))
		 (user-account
		  (name "admin")
		  (comment "Progtest")
		  (group "users")
		  (password (crypt "progtest" "salt"))
		  (shell (file-append (specification->package "bash") "/bin/bash"))
		  (supplementary-groups
		   '("wheel" "netdev" "audio" "video")))
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
