(define-module (atlas config system services)
  #:use-module (atlas services btrbk)
  #:use-module (atlas services morrowind)
  #:use-module (atlas combinators)
  #:use-module (gnu)
  #:use-module (gnu services)
  #:use-module (gnu system pam)
  #:use-module (guix gexp)
  #:use-module (nongnu services vpn))

(use-package-modules
 cups messaging wm gnome)

(use-service-modules
  base
  cuirass
  cups
  databases
  desktop
  docker
  file-sharing
  home
  messaging
  networking
  nix
  pm
  sound
  ssh
  syncthing
  virtualization
  xorg
  vpn)

(define-public %services
  (compose
   (if-host "hydra" (&s hurd-vm))
   (&s cuirass
       (interval (* 24 60 60))
       (host "0.0.0.0")
       (use-substitutes? #t)
       (specifications
        #~(list (specification
                 (name "atlas")
                 (build '(channels atlas))
                 (channels
                  (cons
                   (channel
                    (name 'atlas)
                    (url "https://git.sr.ht/~michal_atlas/guix-channel")
                    (introduction
                     (make-channel-introduction
                      "f0e838427c2d9c495202f1ad36cfcae86e3ed6af"
                      (openpgp-fingerprint
                       "D45185A2755DAF831F1C3DC63EFBF2BBBB29B99E"))))
                   %default-channels))))))
   (if-host "hydra"
            (&s quassel)
            (&s tes3mp-server))
   (&s pam-limits #:config
       (list
        (pam-limits-entry "*" 'both 'nofile 524288)))

   (+s hosts
       (list (host (string-join '("201" "a50e" "ca2d" "72bf"
                                  "89aa" "e12" "e14d" "f2e6") ":") "hydra")
             (host (string-join '("200" "ac59" "de15" "abe5"
                                  "650e" "7139" "f561" "c2fb") ":") "dagon")
             (host (string-join '("200" "29bd" "a495" "4ad7"
                                  "f79e" "e29a" "181a" "3872") ":") "lana")))

   (&s openssh)
   (&s gnome-desktop)
   (&s gpm)
   (&s docker)
   (&s yggdrasil
    (json-config
     '((peers .
              #( ;; Czechia
                "tls://[2a03:3b40:fe:ab::1]:993"
                "tls://37.205.14.171:993"
                ;; Germany
                "tcp://193.107.20.230:7743")))))
   (&s tlp
    (cpu-boost-on-ac? #t)
    (wifi-pwr-on-bat? #t))

   (&s btrbk
    (config
     (plain-file "btrbk.conf"
                 "
backend btrfs-progs-sudo
volume /home
 subvolume .
  snapshot_create onchange
  snapshot_dir .btrfs
  snapshot_preserve 24h 31d 4w 12m
  snapshot_preserve_min latest
  timestamp_format long-iso
")))
   (&s inputattach)
   (&s qemu-binfmt
    (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64")))
   (&s libvirt)
   (&s virtlog (max-clients 1000))
   (&s cups
    (web-interface? #t)
    (extensions
     (list cups-filters hplip-minimal)))
   (&s guix-publish
    (host "0.0.0.0")
    (advertise? #t))
   (&s transmission-daemon
    (rpc-bind-address "127.0.0.1")
    (ratio-limit-enabled? #t))
   (&s postgresql)
   (&s nix (extra-config
         '("experimental-features = nix-command flakes\n"
           "trusted-users = @wheel\n")))
   (&s bluetooth)
   (&s ipfs (gateway "/ip4/0.0.0.0/tcp/8080"))
   (apply services
    (modify-services %desktop-services
                     (network-manager-service-type configuration =>
                                                   (network-manager-configuration
                                                    (inherit configuration)
                                                    (vpn-plugins
                                                     (list network-manager-openvpn))))
                     (gdm-service-type configuration =>
		                       (gdm-configuration
			                (inherit configuration)
			                (auto-login? #t)
			                (default-user "michal_atlas")
			                (wayland? #t)))
                     (delete pulseaudio-service-type)
                     (guix-service-type configuration =>
                                        (guix-configuration
                                         (discover? #t)
                                         (substitute-urls
                                          (cons* "https://substitutes.nonguix.org"
                                                 "https://guix.bordeaux.inria.fr"
                                                 %default-substitute-urls))
                                         (authorized-keys
                                          (append (list
                                                   (plain-file "non-guix.pub"
                                                               "(public-key (ecc (curve Ed25519) (q #926B78EBA9416220CA0AFA2EAEC8ED99FC9E9C03AF11CD08AE6F8192BCF68673#)))")
                                                   (plain-file "hydra.pub"
                                                               "(public-key (ecc (curve Ed25519) (q #6544BC5D41A16DF594F8AA088B7CD6F840590B83FE1D2500FE79E4A4D067F964#)))")
                                                   (plain-file "dagon.pub"
                                                               "(public-key (ecc (curve Ed25519) (q #F5E876A29802796DBA7BAD8B7C0FEE90BDD784A70CB2CC8A1365A47DA03AADBD#)))")
                                                   (plain-file "past.pub"
                                                               "(public-key (ecc (curve Ed25519) (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))"))
                                                  %default-authorized-guix-keys))
                                         (build-machines
                                          (list
                                           #~(build-machine
                                              (name "hydra")
                                              (user "michal_atlas")
                                              (systems (list "x86_64-linux"))
                                              (private-key "/home/michal_atlas/.ssh/id_rsa")
                                              (host-key "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFje4GZkT1qpeuWQEy3VHc8xY4B4siD6CiXrkVFDN1Ka"))))))))))
