(add-to-load-path (dirname (current-filename)))

(define-module (home)
  #:use-module (ice-9 match)
  #:use-module (gnu home)
  #:use-module (home services)
  #:use-module (home hydra)
  #:use-module (home unison)
  #:use-module (ice-9 match)
  #:use-module (rde features)
  #:use-module (rde features base)
  #:use-module (rde features fontutils)
  #:use-module (rde features keyboard)
  #:use-module (rde features video)
  #:use-module (rde features libreoffice)
  #:use-module (rde features image-viewers)
  #:use-module (rde features markup)
  #:use-module (rde features xdg)
  #:use-module (rde features gtk)
  #:use-module (rde features bluetooth)
  #:use-module (wm)
  #:export (home-by-host
            current-home))

(define (get-home features)
  (rde-config
   (features features)))

(define feature-legacy-services
  (feature-custom-services
   #:feature-name-prefix 'legacy
   #:home-services (get-services)))

(define feature-common
  (append
   wm
   (list
    (feature-fonts)
    (feature-tex)
    (feature-libreoffice)
    (feature-imv)
    (feature-xdg)
    (feature-gtk3 #:gtk-dark-theme? #t)
    (feature-bluetooth)
    (feature-transmission)
    (feature-emacs)
    (feature-markdown #:headings-scaling? #t)
    (feature-user-info
     #:user-name "michal_atlas"
     #:full-name "Michal Atlas"
     #:email "michal_atlas+repo@posteo.net")
    (feature-keyboard
     #:keyboard-layout
     (keyboard-layout "us,cz" ",ucw" #:options
                      '("grp:caps_switch" "grp_led"
                        "lv3:ralt_switch" "compose:rctrl-altgr"))))))

(define (home-dagon)
  (get-home
   (cons* feature-legacy-services
          (feature-unison #:peer "hydra")
          feature-common)))

(define (home-hydra)
  (get-home
   (cons* (hydra:features)
          feature-legacy-services
          (feature-unison #:peer "dagon")
          feature-common)))

(define (home-by-host host)
  ((match host
     ("dagon" home-dagon)
     ("hydra" home-hydra))))

(define current-home
  (home-by-host (gethostname)))

;; (pretty-print-rde-config current-home)

(rde-config-home-environment current-home)
