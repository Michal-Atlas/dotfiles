(define-module (atlas system services)
  #:use-module (gnu)
  #:use-module (nongnu services vpn)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages display-managers)
  #:use-module (ice-9 textual-ports))


(use-service-modules
 desktop
 networking
 docker
 ssh
 xorg
 pm
 sddm
 mcron
 nix
 shepherd
 virtualization
 admin
 vpn
 audio
 databases
 cups
 linux
 syncthing)

(define-public %system-services-manifest
  (cons*
   (service openssh-service-type)
   (pam-limits-service
    (list
     (pam-limits-entry "*" 'both 'nofile 524288)))
   ;;(service gnome-desktop-service-type)
   (service gpm-service-type)
   (service docker-service-type)
   (screen-locker-service swaylock "swaylock")
   (service tlp-service-type
	    (tlp-configuration
	     (cpu-boost-on-ac? #t)
	     (wifi-pwr-on-bat? #t)))
   (service inputattach-service-type)
   (zerotier-one-service)
   (service libvirt-service-type
	    (libvirt-configuration
	     (unix-sock-group "libvirt")
	     (tls-port "16555")))
   (service virtlog-service-type
	    (virtlog-configuration
	     (max-clients 1000)))
   (service hurd-vm-service-type)
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
   #;(service mpd-service-type
   (mpd-configuration
   (user "michal_atlas")
   (music-dir "~/music")))
   ;; (service postgresql-service-type)
   (service nix-service-type)
   #;(service unattended-upgrade-service-type
   (unattended-upgrade-configuration
   (channels "/home/michal_atlas/.config/guix/channels.scm")))
   (bluetooth-service #:auto-enable? #f)
   (modify-services
    %desktop-services
    (delete gdm-service-type)
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
			    "(public-key (ecc (curve Ed25519) (q #BF0EF95C0C737FC88417CB38FA582D70E53FCE542AA89D8A11D9DA1A2A33A5BA#)))")
		(plain-file "dagon.pub"
			    "(public-key (ecc (curve Ed25519) (q #6C56CDDAABA765DA1E5137011B33B219941DFAD26E2D823F69DA50F8C888A384#)))"))
	       %default-authorized-guix-keys)))))
   ))
