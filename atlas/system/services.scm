(define-module (atlas system services)
  #:use-module (gnu)
  #:use-module (nongnu services vpn)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages display-managers)
  #:use-module (ice-9 textual-ports))


(use-service-modules
 admin
 audio
 cups
 databases
 desktop
 docker
 file-sharing
 linux
 mcron
 networking
 nix
 pm
 sddm
 shepherd
 ssh
 syncthing
 virtualization
 vpn
 xorg)

(define-public %system-services-manifest
  (cons*
   (service openssh-service-type)
   (pam-limits-service
    (list
     (pam-limits-entry "*" 'both 'nofile 524288)))
   (service gpm-service-type)
   (screen-locker-service xlock "xlock")
   (service docker-service-type)
   (service tlp-service-type
	    (tlp-configuration
	     (cpu-boost-on-ac? #t)
	     (wifi-pwr-on-bat? #t)))
   (service inputattach-service-type)
   (service qemu-binfmt-service-type
         (qemu-binfmt-configuration
           (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64"))))
   (zerotier-one-service)
   (service libvirt-service-type
	    (libvirt-configuration
	     (unix-sock-group "libvirt")
	     (tls-port "16555")))
   (service virtlog-service-type
	    (virtlog-configuration
	     (max-clients 1000)))
   #;
   (service hurd-vm-service-type
	    (hurd-vm-configuration
	     (disk-size (* 16 (expt 2 30)))
	     (memory-size 2048)))
   (service syncthing-service-type
	    (syncthing-configuration (user "michal_atlas")))
   (service cups-service-type
	    (cups-configuration
	     (web-interface? #t)
	     (extensions
	      (list cups-filters hplip-minimal))))
   (service guix-publish-service-type
	    (guix-publish-configuration
	     (host "0.0.0.0")
	     (advertise? #t)))
   (service transmission-daemon-service-type
	    (transmission-daemon-configuration
	     (rpc-bind-address "127.0.0.1")
	     (ratio-limit-enabled? #t)))
   #;(service mpd-service-type
   (mpd-configuration			;
   (user "michal_atlas")		;
   (music-dir "~/music")))
   (service postgresql-service-type)
   (service nix-service-type)
   #;(service unattended-upgrade-service-type
   (unattended-upgrade-configuration
   (channels "/home/michal_atlas/.config/guix/channels.scm")))
   (bluetooth-service #:auto-enable? #f)
   (modify-services
    %desktop-services
    ;; (delete gdm-service-type)
    (gdm-service-type
     config =>
     (gdm-configuration
      #; (auto-login? #t)
      (default-user "michal_atlas")
      (wayland? #t)
      (auto-suspend? #f)
      (xorg-configuration
       (xorg-configuration
	(extra-config (list "# Touchpad
Section \"InputClass\"
Identifier \"touchpad\"
        Driver \"libinput\"
MatchIsTouchpad \"on\"
Option \"DisableWhileTyping\" \"on\"
Option \"Tapping\" \"1\"
Option \"NaturalScrolling\" \"1\"
Option \"Emulate3Buttons\" \"yes\"
EndSection
# Touchpad:1 ends here"))
	(keyboard-layout
	 (keyboard-layout "us,cz" ",ucw" #:options
			  '("grp:caps_switch" #;"ctrl:nocaps" "grp_led"
			    "lv3:ralt_switch" "compose:rctrl-altgr")))))))
    (guix-service-type
     config =>
     (guix-configuration
      (inherit config)
      (discover? #t)
      (substitute-urls
       (append (list
		"https://substitutes.nonguix.org")
	       %default-substitute-urls))
      (authorized-keys
       (append (list
		(plain-file "non-guix.pub"
			    "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
		(plain-file "hydra.pub"
			    "(public-key (ecc (curve Ed25519) (q #3AC168A3D1DA2DDAF87AACB7F02091AF50C093F2A590297C00B1FECDECFFBEA4#)))")
		(plain-file "dagon.pub"
			    "(public-key (ecc (curve Ed25519) (q #D3D457964156E28FBA767F66ED72CC07DE71B9DBFCEAFDBA00652DBFA80D6B46#)))"))
	       %default-authorized-guix-keys)))))
   ))
