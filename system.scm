(add-to-load-path (dirname (current-filename)))

(define-module (system)
  #:use-module ((system mounts dagon) #:prefix dagon:)
  #:use-module ((system mounts hydra) #:prefix hydra:)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 match)
  #:use-module (guix gexp)
  #:use-module (gnu system)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system setuid)
  #:use-module (gnu packages samba)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system nss)
  #:use-module (gnu system linux-initrd)
  #:use-module (ice-9 textual-ports)
  #:use-module (ice-9 popen)
  #:use-module (system base)
  #:use-module (system hostname)
  #:use-module (system btrbk)
  #:use-module (system dagon)
  #:use-module (system hydra)
  #:use-module (system services)
  #:use-module (system networks wireguard)
  #:export (get-system))

(define (getlabel system)
  (chdir "/home/michal_atlas/cl/dotfiles/")
  (string-join
   (list
    (operating-system-default-label system)
    (string-trim-both
     (get-string-all
      (open-pipe* OPEN_READ
                  "git" "log" "-1" "--pretty=reference"))))
   " - "))

(define services (make-parameter '()))
(define file-systems (make-parameter '()
                                     (lambda (fs)
                                       (append
                                        %base-file-systems
                                        fs))))
(define swap-devices (make-parameter '()))
(define mapped-devices (make-parameter '()))

(define (get-system)
  (let ((services (services))
        (swap-devices (swap-devices)))
   (operating-system
    (host-name (hostname))
    (kernel linux)
    (initrd microcode-initrd)
    (initrd-modules %base-initrd-modules)
    (label (getlabel this-operating-system))
    (locale "en_US.utf8")
    (timezone "Europe/Prague")
    (keyboard-layout
     (keyboard-layout "us,cz" ",ucw" #:options
                      '("grp:caps_switch" "grp_led"
                        "lv3:ralt_switch" "compose:rctrl-altgr")))
    (setuid-programs
     (append (list (setuid-program
                    (program (file-append cifs-utils "/sbin/mount.cifs"))))
             %setuid-programs))
    (bootloader
     (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets `("/boot/efi"))))
    (packages %base-packages)
    (services services)
    (name-service-switch %mdns-host-lookup-nss)
    (file-systems (file-systems))
    (swap-devices swap-devices)
    (mapped-devices (mapped-devices)))))

(define (system-dagon)
  (parameterize
      ((hostname "dagon")
       (file-systems dagon:file-systems)
       (swap-devices dagon:swap-devices)
       (mapped-devices dagon:mapped-devices)
       (build-machines
        (list
         #~(build-machine
            (name "hydra")
            (user "michal_atlas")
            (systems (list "x86_64-linux"))
            (private-key "/home/michal_atlas/.ssh/id_rsa")
            (host-key "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINAIrtjcu5p0bORlaVvkqGgeSxD+uUUp114CaXOBOgqQ"))))
       (btrbk-schedule "24h 7d")
       (btrbk-path "/home/michal_atlas")
       (wireguard:keepalive 24))
    (parameterize
        ((services (append dagon:services
                           (get-services))))
      (get-system))))

(define (system-hydra)
  (parameterize
      ((hostname "hydra")
       (file-systems hydra:file-systems)
       (swap-devices hydra:swap-devices)
       (mapped-devices hydra:mapped-devices)
       (btrbk-schedule "24h 31d 4w 12m")
       (wireguard:keepalive 24))
    (parameterize
        ((services (append hydra:services
                           (get-services))))
      (get-system))))

(define (system-by-host host)
 ((match host
    ("dagon" system-dagon)
    ("hydra" system-hydra))))

(define current-system
  (system-by-host (gethostname)))

current-system
