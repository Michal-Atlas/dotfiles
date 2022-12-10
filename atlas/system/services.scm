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
			    "(public-key (ecc (curve Ed25519) (q #3AC168A3D1DA2DDAF87AACB7F02091AF50C093F2A590297C00B1FECDECFFBEA4#)))")
		(plain-file "dagon.pub"
			    "(public-key (ecc (curve Ed25519) (q #D3D457964156E28FBA767F66ED72CC07DE71B9DBFCEAFDBA00652DBFA80D6B46#)))"))
	       %default-authorized-guix-keys)))))
   ))
