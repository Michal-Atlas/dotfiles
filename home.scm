(define-module (home)
  #:use-module (beaver system)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services fontutils)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services desktop)
  #:use-module (gnu services)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu services xorg)
  #:use-module (gnu packages mpd)
  #:use-module (gnu packages music)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu home services mcron)
  #:use-module (ice-9 hash-table)
  #:use-module (gnu system keyboard)
  #:use-module (guix gexp)
  #:use-module (guix base64)
  #:use-module (guix download)
  #:use-module (guix channels)
  #:use-module (guix modules)
  #:use-module (guix monads)
  #:use-module (guix store)
  #:use-module (guix derivations)
  #:use-module (ice-9 match)
  #:use-module (gnu packages gnome)
  #:use-module (guix packages)
  #:use-module (guix build-system copy)
  #:use-module (guix download)
  #:use-module (gnu services configuration)
  #:use-module (gnu packages package-management)
  #:use-module (guix records)
  #:use-module (gnu packages image)
  #:use-module (guixrus home services emacs)
  #:use-module (atlas home services sway)
  #:use-module (atlas home services git)
  #:use-module (atlas home services flatpak))



(define my-layout
  (keyboard-layout "us,cz" ",ucw" #:options
		   '("grp:caps_switch" "grp_led"
		     "lv3:ralt_switch" "compose:rctrl-altgr")))

(define (file-fetch url hash)
  (with-store store
              (run-with-store store
                              (url-fetch url 'sha256 (base64-decode hash)))))

(define rsync-dirs '("Sync" "cl" "Documents" "Zotero"))
(define rsync-target
  (assoc-ref
   `(("hydra" . "dagon.local")
     ("dagon" . "hydra.local"))
   (vector-ref (uname) 1)))

(define-syntax .service
  (lambda (x)
   (syntax-case x ()
     [(_ name config ...)
      (with-syntax
          ([service-type (datum->syntax x (symbol-append
                                           (syntax->datum #'name)
                                           '-service-type))]
           [configuration (datum->syntax x (symbol-append
                                            (syntax->datum #'name)
                                            '-configuration))])
        #'(service service-type
                   (configuration
                    config ...)))])))

(define-syntax +service
  (lambda (x)
   (syntax-case x ()
     [(_ name config)
      (with-syntax
          ([service-type (datum->syntax x (symbol-append
                                           (syntax->datum #'name)
                                           '-service-type))])
        #'(simple-service (format #f "~a extension" service-type)
                          service-type
                          config))])))

(home-environment
 (services
  (list
   (service home-channels-service-type
            (cons*
             (channel
              (name 'nonguix)
              (url "https://gitlab.com/nonguix/nonguix")
              (branch "master")
              (introduction
               (make-channel-introduction
                "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
                (openpgp-fingerprint
                 "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
             (channel
              (name 'guixrus)
              (url "https://git.sr.ht/~whereiseveryone/guixrus")
              (introduction
               (make-channel-introduction
                "7c67c3a9f299517bfc4ce8235628657898dd26b2"
                (openpgp-fingerprint
                 "CD2D 5EAA A98C CB37 DA91  D6B0 5F58 1664 7F8B E551"))))
             (channel
              (name 'atlas)
              (url "https://git.sr.ht/~michal_atlas/guix-channel"))
             (channel
              (name 'guix-gaming-games)
              (url "https://gitlab.com/guix-gaming-channels/games.git")
              (introduction
               (make-channel-introduction
                "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
                (openpgp-fingerprint
                 "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))
             (channel
              (name 'beaver-labs)
              (url "https://gitlab.com/edouardklein/guix")
              (branch "beaverlabs"))
             %default-channels))
   (service home-sway-service-type
            (home-sway-configuration
             (sway
              `((set $mod "Mod4")
                ,(sway-keyboard-layout my-layout)

                (input "1739:32382:DELL0740:00_06CB:7E7E_Touchpad"
                       ((dwt enabled)
                        (tap enabled)
                        (natural_scroll enabled)
                        (middle_emulation enabled)))

                (output "*"
                        ((bg ,(file-fetch "https://ift.tt/2UDuBqa"
                                          "i7XCgxwaBYKB7RkpB2nYcGsk2XafNUPcV9921oicRdo=")
                             fill)))
              
                ,@(sway-exec-bindings
                   `(("y" ,(file-append kitty "/bin/kitty unison"))
                     ("Return" ,(file-append emacs-next-pgtk "/bin/emacsclient -c"))
                     ("d" ,(file-append bemenu "/bin/bemenu-run"))
                     ("t" ,(file-append kitty "/bin/kitty"))
                     (("Shift" "e") "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'")
                     (("Shift" "s")
                      "DIM=\"$(" ,(file-append slurp "/bin/slurp") "\""
                      " && " ,(file-append grim "/bin/grim")
                      " ~/tmp/$(date +'%s_grim.png') -g \"$DIM\" "
                      "&& " ,(file-append grim "/bin/grim")
                      " -g \"$DIM\" - | wl-copy --type image/png")))
                ,@(let* ((pactl-exec
                          (lambda (cmd)
                            (file-append pulseaudio (string-append "/bin/pactl " cmd))))
                         (edit-audio-by
                          (lambda (n)
                            (pactl-exec
                             (string-append "set-sink-volume @DEFAULT_SINK@ " n))))
                         (playerctl-exec (lambda (cmd) (file-append playerctl "/bin/playerctl " cmd))))
                    (sway-exec-bindings/nomod
                     `(("XF86AudioPrev" ,(playerctl-exec "previous"))
                       ("XF86AudioNext" ,(playerctl-exec "next"))
                       ("XF86AudioPlay" ,(playerctl-exec "play-pause"))
                       ("XF86AudioRaiseVolume" ,(edit-audio-by "+5%"))
                       ("XF86AudioLowerVolume" ,(edit-audio-by "-5%"))
                       ("XF86AudioMute" ,(pactl-exec "set-sink-mute @DEFAULT_SINK@ toggle"))
                       ("XF86AudioMicMute" ,(pactl-exec "set-source-mute @DEFAULT_SOURCE@ toggle"))

                       ("XF86MonBrightnessUp"
                        ,(file-append brightnessctl "/bin/brightnessctl s +10%"))
                       ("XF86MonBrightnessDown"
                        ,(file-append brightnessctl "/bin/brightnessctl s 10%-")))))
                ,@(sway-bindings
                   `((("Shift" "q") kill)
                     (("Shift" "c") reload)
                     ,@(let ((dirs '("Left" "Right" "Up" "Down")))
                         (append
                          (map (lambda (q) `(,q ,(string-append "focus " (string-downcase q))))
                               dirs)
                          (map (lambda (q) `(("Shift" ,q)
                                        ,(string-append "move " (string-downcase q))))
                               dirs)))
                     ,@(map (compose (lambda (q) `(,q ,(string-append "workspace number " q)))
                                     number->string)
                            (iota 9))
                     ,@(map (compose (lambda (q) `(("Shift" ,q)
                                              ,(string-append "move container to workspace number " q)))
                                     number->string)
                            (iota 9))
                     ("b" splith)
                     ("v" splitv)
                   
                     ("s" layout stacking)
                     ("w" layout tabbed)
                     ("e" layout toggle split)

                     ("f" fullscreen)

                     (("Shift" "space") floating toggle)
                     ("space" focus mode_toggle)
                     (("Shift" "minus") move scratchpad)
                     ("minus" scratchpad show)))
                (floating_modifier $mod normal)
                (bar
                 ((position "top")
                  (status_command ,(file-append i3status "/bin/i3status"))
                  (colors
                   (("statusline" "#ffffff")
                    ("background" "#323232")
                    ("inactive_workspace" "#32323200" "#32323200" "#5c5c5c")))))

                (exec ,(file-append i3-autotiling "/bin/autotiling"))
              
                "exec swayidle -w \
                timeout 1200 'playerctl status || swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"' \
                before-sleep 'swaylock -f -c 000000'"))

             (status
              `((general ((output_format = "i3bar")
                          (colors = true)
                          (interval = 5)))
                
                ,@(map (lambda (id) `(order += ,id))
                       `("ipv6"
                         "disk /"
                         "wireless wlp1s0"
                         "battery 0"
                         "memory"
                         "read_file brightness"
                         "volume master"
                         "time local"))
                (wireless wlp1s0 ((format_up = "W: %ip @ %essid")
                                  (format_down = "W: down")))
                (battery 0 ((format = "%status %percentage %emptytime")
                            (format_down = "No battery")
                            (status_chr = "CHR")
                            (status_bat = "BAT")
                            (status_unk = "UNK")
                            (status_full = "FUL")
                            (path = "/sys/class/power_supply/BAT%d/uevent")
                            (last_full_capacity = true)
                            (low_threshold = 20)))
                (time ((format = "%Y-%m-%d %H:%M:%S")))
                (memory  ((format = "MEM: %used")
                          (threshold_degraded = "10%")
                          (format_degraded = "MEM: %free")))
                (disk "/" ((format = "/: %free")))
                (volume master ((device = "pulse")
                                (format = "VOL: %volume")
                                (format_muted = "VOL: __%")))
                (read_file brightness ((path = "/sys/class/backlight/intel_backlight/brightness")
                                       (format = "BRT: %content")))))))

   (.service home-shepherd
      (services
       (list
        (shepherd-service
         (provision '(disk-automount))
         (start #~(make-forkexec-constructor
	           (list #$(file-append udiskie "/bin/udiskie"))))
         (stop #~(make-kill-destructor))))))

   (.service home-mcron
      (jobs
       (list
        #~(job "0 * * * *"
	       (string-append 
	        #$(file-append findutils "/bin/find")
	        " ~/tmp/ ~/Downloads/ -mindepth 1 -mtime +2 -delete;"))
        #~(job "0 * * * *"
	       "guix gc -F 20G"))))

   (.service home-git
      (name "Michal Atlas")
      (email "michal_atlas+git@posteo.net"))

   (+service home-files
      ;; local-file being explicit allows earlier check for file existence
      `((".emacs.d/init.el" ,(local-file "files/emacs.el"))
        (".guile" ,(local-file "files/guile.scm"))
        (".sbclrc" ,(local-file "files/sbcl.lisp"))
        (".local/share/nyxt/bookmarks.lisp" ,(local-file "files/nyxt/bookmarks.lisp"))
        (".config/nyxt/config.lisp" ,(local-file "files/nyxt/init.lisp"))
        (".unison/default.prf"
         ,(mixed-text-file "unison-profile"
                           "root=/home/michal_atlas\n"
                           "root=ssh://"
                           rsync-target
                           "//home/michal_atlas\n"
                         
                           "path=Sync\n"
                           "path=Documents\n"
                           "path=cl\n"
                           "path=Zotero\n"
                           "auto=true\n"
                           ;; "batch=true\n"
                           "log=true\n"
                           ;; "repeat=watch\n"
                           "sortbysize=true\n"))))

   (.service home-bash
      (guix-defaults? #t)
      (bashrc
       (list
        (mixed-text-file "bashrc-direnv"
		         "eval \"$("
		         direnv "/bin/direnv"
		         " hook bash)\"")
        (plain-file "bashrc-ignoredups" "export HISTCONTROL=ignoredups")
        (mixed-text-file "bashrc-run"
		         "function run { "
		         guix "/bin/guix"
		         " shell $1 -- $@; }")
        (mixed-text-file "bashrc-valgrind"
		         "alias valgrind=\""
		         guix "/bin/guix"
		         " shell -CF valgrind -- valgrind \"")
        (mixed-text-file "bashrc-fasd" "eval \"$("
		         fasd "/bin/fasd"
		         " --init auto)\"")
        (mixed-text-file "bashrc-cheat"
		         "function cheat { "
		         curl "/bin/curl"
		         " \"cheat.sh/$@\"; }")))

      (aliases `
       (("gx" . "guix")
        ("gxi" . "gx install")
        ("gxb" . "gx build")
        ("gxs" . "gx search")
        ("gxsh" . "gx shell")
        ("gxtm" . "gx time-machine")
        ("e" . "$EDITOR")
        ("sw" . "swayhide")
        ("cat" . "bat -p")
        ("recon-home" . "guix home reconfigure $HOME/cl/dotfiles/home.scm")
        ("recon-system" . "sudo guix system reconfigure $HOME/cl/dotfiles/system.scm")
        ("recon-home-time" . "guix time-machine -C $HOME/.guix-home/channels.scm -- home reconfigure $HOME/cl/dotfiles/home.scm")
        ("recon-system-time" . "sudo guix time-machine -C /run/current-system/channels.scm -- system reconfigure $HOME/cl/dotfiles/system.scm")))

      (environment-variables
       `(("BROWSER" . "firefox") ("EDITOR" . "emacsclient -n -c")
         ("TERM" . "xterm-256color") ("MOZ_ENABLE_WAYLAND" . "1")
         ("MOZ_USE_XINPUT2" . "1") ("GRIM_DEFAULT_DIR" . "~/tmp")
         ("_JAVA_AWT_WM_NONREPARENTING" . "1")
         ("PATH" . "$HOME/.nix-profile/bin/:$PATH")
         ("PATH" . "$PATH:$HOME/bin/")
         ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/bin")
         ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/dotfiles")
         ("GUIX_SANDBOX_HOME" . "/GAMES")
         ("ALTERNATE_EDITOR" . ""))))

   (.service home-flatpak
      (packages
       '(("flathub"
          "com.discordapp.Discord"
          "org.telegram.desktop"
          "org.zotero.Zotero"
          "com.spotify.Client"))))

   (.service home-openssh
      (hosts (append
	      (list
	       (openssh-host
	        (name "Myst")
	        (host-name "34.122.2.188"))
	       (openssh-host
	        (name "ZmioSem")
	        (user "michal_zacek")
	        (port 10169)
	        (host-name "hiccup.mazim.cz"))
               (openssh-host
                (name "the-dam")
                (user "atlas")
                (host-name "the-dam.org")
                (identity-file (string-append
                                (getenv "HOME")
                                "/.ssh/the-dam"))))
	      (map (lambda (q)
		     (openssh-host
		      (name (string-append "Fray" q))
		      (host-name (string-append "fray" q ".fit.cvut.cz"))
		      (user "zacekmi2")
		      (host-key-algorithms (list "+ssh-rsa"))
		      (accepted-key-types (list "+ssh-rsa"))
		      (extra-content "  ControlMaster auto")))
	           '("1" "2"))))
      (authorized-keys (list (local-file "keys/hydra.pub")
			     (local-file "keys/dagon.pub")
                             (local-file "keys/arc.pub")))))))
