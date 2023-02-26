(define-module (atlas hurd)
  #:use-module (gnu system)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system nss)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages hurd))

(operating-system
 (host-name "startide")
 (file-systems %base-file-systems)
 (kernel hurd)
 (locale "en_US.utf8")
 (timezone "Europe/Prague")
 (keyboard-layout
  (keyboard-layout "us,cz" ",ucw" #:options
		   '("grp:caps_switch" #;"ctrl:nocaps" "grp_led"
		     "lv3:ralt_switch" "compose:rctrl-altgr")))
 (users (cons* (user-account
		(name "michal_atlas")
		(comment "Michal Atlas")
		(group "users")
		(home-directory "/home/michal_atlas")
		(supplementary-groups
		 '("wheel" "netdev" "audio" "video")))
	       %base-user-accounts))
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets `("/boot/efi"))))
 (name-service-switch %mdns-host-lookup-nss))
