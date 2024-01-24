(define-module (config)
  #:use-module (atlas utils download)
  #:use-module (rde home services shellutils)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages rust-apps)
  #:use-module (rde gexp)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (guix gexp)
  #:use-module (ice-9 match)
  #:use-module (gnu home)
  #:use-module (home services)
  #:use-module ((system services) #:prefix sys:)
  #:use-module ((mounts dagon) #:prefix dagon:)
  #:use-module ((mounts hydra) #:prefix hydra:)
  #:use-module ((system dagon) #:prefix sys:)
  #:use-module ((system hydra) #:prefix sys:)
  #:use-module (home hydra)
  #:use-module (home unison)
  #:use-module (ice-9 match)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (system btrbk)
  #:use-module (rde system services accounts)
  #:use-module (rde system services admin)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features fontutils)
  #:use-module (rde features keyboard)
  #:use-module (rde features video)
  #:use-module (rde features libreoffice)
  #:use-module (rde features system)
  #:use-module (rde features image-viewers)
  #:use-module (rde features markup)
  #:use-module (rde features xdg)
  #:use-module (rde features gtk)
  #:use-module (rde features bluetooth)
  #:use-module (rde features networking)
  #:use-module (rde features terminals)
  #:use-module (rde features bittorrent)
  #:use-module (rde features virtualization)
  #:use-module (rde features gnupg)
  #:use-module (rde features version-control)
  #:use-module (rde features shells)
  #:use-module (rde features shellutils)
  #:use-module (rde features web-browsers)
  #:use-module (rde features lisp)
  #:use-module (networks wireguard)
  #:use-module ((networks yggdrasil) #:prefix net:)
  #:use-module (wm)
  #:use-module (emacs)
  #:export (config-for-host))

(define feature-legacy-services
  (feature-custom-services
   #:feature-name-prefix 'legacy
   #:home-services (get-services)
   #:system-services (sys:get-services)))

(define feature-common
  (append
   wm
   emacs
   (list
    feature-legacy-services
    (feature-kernel
     #:kernel linux
     #:initrd microcode-initrd)
    (feature-base-services
     #:base-system-services
     (modify-services (@@ (rde features base) %rde-base-system-services)
       (guix-service-type
        config =>
        (guix-configuration
         (inherit config)
         (discover? #t))))
     #:guix-substitute-urls
     (list "https://guix.bordeaux.inria.fr"
           "https://substitutes.nonguix.org")
     #:guix-authorized-keys
     (list
      (plain-file "non-guix.pub"
                  "(public-key (ecc (curve Ed25519) (q #926B78EBA9416220CA0AFA2EAEC8ED99FC9E9C03AF11CD08AE6F8192BCF68673#)))")
      (plain-file "hydra.pub"
                  "(public-key (ecc (curve Ed25519) (q #629C1EFAFAB6A1D70E0CBC221C3F164226EBF72E52401CACEA0444CACA89E0D2#)))")
      (plain-file "dagon.pub"
                  "(public-key (ecc (curve Ed25519) (q #F5E876A29802796DBA7BAD8B7C0FEE90BDD784A70CB2CC8A1365A47DA03AADBD#)))")
      (plain-file "past.pub"
                  "(public-key (ecc (curve Ed25519) (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))")))
    (feature-desktop-services)
    (feature-hidpi)
    (feature-fonts)
    (feature-tex)
    (feature-libreoffice)
    (feature-imv)
    (feature-xdg)
    (feature-gtk3 #:gtk-dark-theme? #t)
    (feature-bluetooth)
    (feature-transmission)
    (feature-markdown #:headings-scaling? #t)
    (feature-foot)
    (feature-qemu)
    (feature-networking
     #:mdns? #t)
    (feature-gnupg
     #:gpg-primary-key "3EFBF2BBBB29B99E")
    (feature-git
     #:git-gpg-sign-key "3EFBF2BBBB29B99E"
     #:extra-config
     `((pull
        ((rebase . #t)))
       (rebase
        ((autostash . #t)))
       (sendemail
        ((smtpserver . "posteo.de")
         (smtpserverport . 587)
         (smtpencryption . "tls")
         (smtpuser . ,(string-append
                       "michal_atlas"
                       "@"
                       "posteo.net"))))
       (filter "lfs"
               ((process . "git-lfs filter-process")
                (required . #t)
                (clean . "git-lfs clean -- %f")
                (smudge . "git-lfs smudge -- %f")))))
    (feature-direnv)
    (feature-zsh
     #:zshrc
     (map slurp-file-like
          (list
           (plain-file "fasd" "eval \"$(fasd --init auto)\"")
           (mixed-text-file
            "bashrc-pp"
            "function pp() { "
            (program-file
             "pp"
             #~(begin
                 (use-modules (ice-9 pretty-print))
                 (call-with-input-file (cadr (command-line))
                   (lambda (f)
                     (let loop ((r (read f)))
                       (unless (eof-object? r)
                         (pretty-print r)
                         (loop (read f))))))))
            " $1 | "
            bat "/bin/bat"
            " -pl lisp; }")
           (mixed-text-file "fzf-history"
                            ". "
                            (file-fetch "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh"
                                        "q2KdZrpVpetitWJpe/mzC5Cl2jfx42BMJ4wM0q6+2rM="))
           (mixed-text-file "bashrc-cheat"
                            "function cheat { "
                            curl "/bin/curl"
                            " \"cheat.sh/$@\"; }")
           (mixed-text-file
            "bashrc-nuix"
            "function nix() { case \"$1\" in "
            "build) " nix "/bin/nix \"$1\" --no-link --print-out-paths \"${@:2}\";; "
            "*)" nix "/bin/nix \"${@:1}\";; "
            "esac;"
            " }")
           (mixed-text-file "prompt"
                            "prompt adam2"))))
    (feature-nyxt
     #:extra-config-lisp
     '((define-configuration (web-buffer prompt-buffer panel-buffer
                                          nyxt/mode/editor:editor-buffer)
          ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))
        (define-configuration browser
          ((theme theme:+dark-theme+)))))
    (feature-lisp
     #:extra-sbclrc-lisp
     '((require 'asdf)
       (require 'linedit)

;;; Check for --no-linedit command-line option.
       (if (member "--no-linedit" sb-ext:*posix-argv* :test 'equal)
           (setf sb-ext:*posix-argv*
                 (remove "--no-linedit" sb-ext:*posix-argv* :test 'equal))
           (when (interactive-stream-p *terminal-io*)
             (linedit:install-repl :wrap-current t :eof-quits t)
             (funcall (intern "INSTALL-REPL" :linedit) :wrap-current t)))))
    (feature-custom-services
     #:system-services
     (list (simple-service 'libvirt rde-account-service-type
                    '("libvirt")))
     #:home-services
     (list
      (service home-zsh-plugin-manager-service-type
               (list zsh-syntax-highlighting
                     zsh-autopair))))
    (net:feature-yggdrasil)
    (feature-wireguard)
    (feature-user-info
     #:user-name "michal_atlas"
     #:full-name "Michal Atlas"
     #:email "michal_atlas+repo@posteo.net")
    (feature-keyboard
     #:keyboard-layout
     (keyboard-layout "us,cz" ",ucw" #:options
                      '("grp:caps_switch" "grp_led"
                        "lv3:ralt_switch" "compose:rctrl-altgr"))))))

(define dagon
  (cons* (feature-unison #:peer "hydra")
         (feature-host-info #:host-name "dagon")
         (feature-file-systems
          #:mapped-devices dagon:mapped-devices
          #:swap-devices dagon:swap-devices
          #:file-systems dagon:file-systems)
         (feature-custom-services
          #:feature-name-prefix 'dagon-legacy
          #:system-services sys:dagon:services)
         (feature-btrbk #:schedule "24h 7d")
         feature-common))

(define hydra
  (cons* (feature-unison #:peer "dagon")
         (feature-host-info #:host-name "hydra")
         (feature-file-systems
          #:mapped-devices hydra:mapped-devices
          #:swap-devices hydra:swap-devices
          #:file-systems hydra:file-systems)
         (feature-custom-services
          #:feature-name-prefix 'hydra-legacy
          #:system-services sys:hydra:services
          #:home-services (hydra:services))
         (feature-btrbk #:schedule "24h 31d 4w 12m")
         feature-common))

(define (config-for-host host)
  (rde-config
   (integrate-he-in-os? #t)
   (features
    (match host
      ("hydra" hydra)
      ("dagon" dagon)))))
