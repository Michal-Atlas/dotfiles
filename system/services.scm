(define-module (system services)
  #:use-module (channels)
  #:use-module (atlas utils services)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)
  #:use-module (guix gexp)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages gnome)
  #:use-module (gnu services dbus)
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
  #:use-module (gnu services home)
  #:use-module (gnu services file-sharing)
  #:use-module (system btrfs)
  #:use-module (system firmware)
  #:use-module (system packages)
  #:use-module (mounts autofs)
  #:use-module (mounts nfs)
  #:use-module (networks wireguard)
  #:use-module (networks yggdrasil)
  #:use-module (networks zerotier)
  #:export (get-services))

(define (common-rules-service vendor product)
  (udev-rules-service
   'quest (udev-rule "51-android-quest.rules"
                     (string-join `("SUBSYSTEM==\"usb\""
                                    ,(string-append "ATTR{idVendor}==\"" vendor "\"")
                                    ,(string-append "ATTR{idProduct}==\"" product "\"")
                                    "MODE=\"0666\""
                                    "GROUP=\"users\"")
                                  ", "))))

(define services
  (list
   #;(&s gdm
       (auto-login? #t)
       (default-user "michal_atlas")
       (auto-suspend? #f)
       (wayland? #t))
   ;(&s gnome-desktop)
   ;(&s wpa-supplicant)
   ;(&s network-manager)
   ;(&s modem-manager)
   ;(&s transmission-daemon)
   (&s usb-modeswitch)
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

   (&s openssh)
   (&s gpm)
   (&s earlyoom)
   (&s fstrim)
   (&s fail2ban)
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
   (common-rules-service "2833" "0186")
   (common-rules-service "18d1" "4ee8")
   (&s nix (extra-config
            '("experimental-features = nix-command flakes\n"
              "trusted-users = @wheel\n")))))

(define (get-services)
  (cons*
   (+s polkit gvfs (list gvfs))
   btrfs-maid
   firmware
   packages
   (autofs:get)
   (nfs:get)
   (append
    (zerotier:get)
    services)))
