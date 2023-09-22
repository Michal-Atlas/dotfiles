(define-library (system services)
  (import (scheme base)
          (only (guile) cons* string-join)
          (home)
          (gnu services)
          (atlas utils services)
          (guix gexp)
          (gnu services cuirass)
          (gnu services virtualization)
          (gnu services messaging)
          (gnu services sound)
          (gnu services syncthing)
          (atlas services morrowind)
          (atlas services btrbk)
          (nongnu services vpn)
          (gnu services base)
          (gnu system pam)
          (gnu services ssh)
          (gnu services xorg)
          (gnu packages wm)
          (gnu services docker)
          (gnu services networking)
          (gnu services pm)
          (gnu services desktop)
          (gnu services cups)
          (gnu packages cups)
          (gnu services file-sharing)
          (gnu services databases)
          (gnu services nix)
          (gnu services home)
          (scheme write))
  (export %services)
  (begin
    (define (%services hostname)
      (append
       (@host hostname
        #:hydra
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
        #:hydra
        (&s quassel)
        #:hydra
        (&s tes3mp-server)
        (&s pam-limits #:config
            (list
             (pam-limits-entry "*" 'both 'nofile 524288)))

        (+s hosts
            (list (host (string-join '("201" "a50e" "ca2d" "72bf"
                                       "89aa" "e12" "e14d" "f2e6") ":") "hydra")
                  (host (string-join '("200" "ac59" "de15" "abe5"
                                       "650e" "7139" "f561" "c2fb") ":") "dagon")
                  (host (string-join '("200" "29bd" "a495" "4ad7"
                                       "f79e" "e29a" "181a" "3872") ":") "lana"))))
       (macromap
        &s
        (openssh)
	(gnome-desktop)
        (gpm)
        (syncthing (user "michal_atlas"))
        (screen-locker
         (name "swaylock")
         (program (file-append swaylock
                               "/bin/swaylock"))
         (using-setuid? #f)
         (using-pam? #t))
        (docker)
        (yggdrasil
         (json-config
          '((peers .
	           #(;; Czechia
	             "tls://[2a03:3b40:fe:ab::1]:993"
	             "tls://37.205.14.171:993"
	             ;; Germany
	             "tcp://193.107.20.230:7743")))))
        (tlp
         (cpu-boost-on-ac? #t)
         (wifi-pwr-on-bat? #t))

        (btrbk
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
        (inputattach)
        (qemu-binfmt
         (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64")))
        (libvirt)
        (virtlog (max-clients 1000))
        (cups
         (web-interface? #t)
         (extensions
          (list cups-filters hplip-minimal)))
        (guix-publish
         (host "0.0.0.0")
         (advertise? #t))
        (transmission-daemon
         (rpc-bind-address "127.0.0.1")
         (ratio-limit-enabled? #t))
        (postgresql)
        (nix (extra-config
              '("experimental-features = nix-command flakes\n"
                "trusted-users = @wheel\n")))
        (bluetooth)
        (ipfs (gateway "/ip4/0.0.0.0/tcp/8080")))
       (modify-services %desktop-services
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
                                                     %default-authorized-guix-keys)))))))))
