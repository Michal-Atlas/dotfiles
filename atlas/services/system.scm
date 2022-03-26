(define-module (atlas services system)
  #:use-module (gnu)
  #:use-module (nongnu services vpn)
  #:use-module (gnu packages cups)
  #:use-module (ice-9 textual-ports))


(use-service-modules
 desktop
 networking
 ssh
 xorg
 pm
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

(define (readfile f)
  (call-with-input-file f get-string-all))

(define-public %system-services-manifest
  (cons*
   (service openssh-service-type)
   (set-xorg-configuration
    (xorg-configuration
     (extra-config
      (list
       (readfile "xorg/touchpad")))))
   (service gnome-desktop-service-type)
   (service mate-desktop-service-type)
   (pam-limits-service
    (list
     (pam-limits-entry "*" 'both 'nofile 524288)))
   (service gpm-service-type)
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
   (service postgresql-service-type)
   (service nix-service-type)
   (service unattended-upgrade-service-type
	    (unattended-upgrade-configuration
 	     (channels "/home/michal-atlas/.config/guix/channels.scm")))
   (bluetooth-service #:auto-enable? #f)
   ;;CTU
   (service openvpn-client-service-type
	    (openvpn-client-configuration
	     (ca 'disabled)
	     (cert 'disabled)
	     (key 'disabled)
	     (auth-user-pass "/root/openvpn")
	     (remote (list
		      (openvpn-remote-configuration
		       (name "vpn.fit.cvut.cz")
		       )))))
   (modify-services
    %desktop-services
    (wpa-supplicant-service-type
     config =>
     (wpa-supplicant-configuration
      (inherit config)
      (config-file "/home/michal-atlas/.cat_installer/cat_installer.conf")))
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
		(plain-file "dagon.pub"
			    "(public-key (ecc (curve Ed25519) (q #33173AD94F3854CD3642E21B59802C275A1742C5D0FFC59EE076EDC23FDDFFC6#)))")
		(plain-file "hydra.pub"
			    "(public-key (ecc (curve Ed25519) (q #7C49484F9CCF50147D7BF1DFFD0F22B2AF424B0CD4228F57CA0C34F80D3A9BDD#)))")
		(plain-file "hydra.pub"
			    "(public-key (ecc (curve Ed25519) (q #9B884798A567CE37ABD37D80ECC104A453D5272989A945C5079335D8E8595DB6#)))"))
	       %default-authorized-guix-keys)))))
   ))
