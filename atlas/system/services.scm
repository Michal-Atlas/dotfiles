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
   (service pam-limits-service-type
    (list
     (pam-limits-entry "*" 'both 'nofile 524288)))
   (service gpm-service-type)
   (service docker-service-type)
   (service gnome-desktop-service-type)
   (service tlp-service-type
	    (tlp-configuration
	     (cpu-boost-on-ac? #t)
	     (wifi-pwr-on-bat? #t)))
   (service inputattach-service-type)
   (service qemu-binfmt-service-type
         (qemu-binfmt-configuration
           (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64"))))
   (zerotier-one-service)
   #;
   (service mpd-service-type
            (mpd-configuration
             (music-directory "/home/michal_atlas/Music/")))
   #;
   (service mympd-service-type)
   (service libvirt-service-type
	        (libvirt-configuration
	         (unix-sock-group "libvirt")
	         (tls-port "16555")))
   (service virtlog-service-type
	    (virtlog-configuration
	     (max-clients 1000)))
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
   (service postgresql-service-type)
   (service nix-service-type)
   #;(service unattended-upgrade-service-type
   (unattended-upgrade-configuration
   (channels "/home/michal_atlas/.config/guix/channels.scm")))
   (service bluetooth-service-type)
   (modify-services %desktop-services
     ;; (delete gdm-service-type)
     (gdm-service-type
      config =>
      (gdm-configuration
       ;; (auto-login? #t)
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
			    "(public-key (ecc (curve Ed25519) (q #926B78EBA9416220CA0AFA2EAEC8ED99FC9E9C03AF11CD08AE6F8192BCF68673#)))")
		(plain-file "hydra.pub"
			    "(public-key (ecc (curve Ed25519) (q #5E7373D527DC6566C2601F79EDD33ADDBCB16CDF1D7A8A12565B76058DB6A219#)))")
		(plain-file "dagon.pub"
			    "(public-key (ecc (curve Ed25519) (q #D3D457964156E28FBA767F66ED72CC07DE71B9DBFCEAFDBA00652DBFA80D6B46#)))"))
	       %default-authorized-guix-keys)))))
   ))
