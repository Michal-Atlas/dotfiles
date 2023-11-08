(define-module (system services)
  #:use-module (atlas utils services)
  #:use-module (gnu services shepherd)
  #:use-module (guix gexp)
  #:use-module (gnu packages linux)
  #:use-module (gnu services admin)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu system pam)
  #:use-module (gnu services xorg)
  #:use-module (gnu packages wm)
  #:use-module (gnu services ssh)
  #:use-module (gnu services linux)
  #:use-module (gnu services security)
  #:use-module (gnu services networking)
  #:use-module (gnu services desktop)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services cups)
  #:use-module (gnu packages cups)
  #:use-module (gnu services file-sharing)
  #:use-module (gnu services nix)
  #:use-module (gnu services databases)
  #:use-module (atlas utils define)
  #:use-module (system account)
  #:use-module (system btrfs)
  #:use-module (system firmware)
  #:use-module (system packages)
  #:use-module (system base)
  #:use-module (system btrbk)
  #:export (configure-services))

(define services
  (list
   (+s shepherd-root rshare-root
       (list
        (shepherd-service
         (provision '(rshare-root))
         (requirement '(file-systems))
         (one-shot? #t)
         (start #~(make-forkexec-constructor
                   (list #$(file-append util-linux+udev
                                        "/bin/mount")
                         "--make-rshared" "/")))
         (stop #~(make-kill-destructor)))))
   (&s file-database)
   (&s package-database)
   (+s etc podman-policy
       `(("containers/policy.json"
          ,(local-file "../files/podman.conf"))
         ("containers/registries.conf"
          ,(local-file "../files/podman-registry.conf"))
         ("subuid"
          ,(plain-file "subuid"
                       "michal_atlas:100000:65536"))
         ("subgid"
          ,(plain-file "subgid"
                       "michal_atlas:100000:65536"))))
   (&s pam-limits #:config
       (list
        (pam-limits-entry "*" 'both 'nofile 524288)))

   (&s screen-locker
       (name "swaylock")
       (program (file-append swaylock
                             "/bin/swaylock"))
       (using-setuid? #f)
       (using-pam? #t))

   (+s hosts yggdrasil-hosts
       (list (host (string-join '("200" "6229" "6335" "8721"
                                  "7ae1" "6b30" "961e" "c172") ":") "hydra")
             (host (string-join '("200" "2b5a" "7e80" "7b31"
                                  "7d15" "6c81" "2563" "62c") ":") "dagon")
             (host (string-join '("200" "29bd" "a495" "4ad7"
                                  "f79e" "e29a" "181a" "3872") ":") "lana")))

   (&s openssh)
   (&s gpm)
   (&s earlyoom)
   (&s fstrim)
   (&s fail2ban)
   (&s yggdrasil
       (json-config
        '((peers .
                 #( ;; Czechia
                   "tls://[2a03:3b40:fe:ab::1]:993"
                   "tls://37.205.14.171:993"
                   ;; Germany
                   "tcp://193.107.20.230:7743")))))
   (&s inputattach)
   (&s qemu-binfmt
       (platforms (lookup-qemu-platforms "arm" "aarch64"
                                         "riscv64" "i686"
                                         "i586")))
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
   (&s nix (extra-config
            '("experimental-features = nix-command flakes\n"
              "trusted-users = @wheel\n")))
   (&s bluetooth)
   (&s postgresql)
   (&s ipfs (gateway "/ip4/0.0.0.0/tcp/8080"))))

(define/cp pass (configure-services)
  (cons*
   accounts
   btrfs-maid
   firmware
   packages
   (pass btrbk)
   (append
    services
    (pass base-services))))
