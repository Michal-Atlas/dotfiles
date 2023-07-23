(define-module (home)
  #:use-module (atlas home services flatpak)
  #:use-module (beaver system)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services fontutils)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services mcron)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services)
  #:use-module (gnu home)
  #:use-module (gnu home-services version-control)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages image)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages mpd)
  #:use-module (gnu packages music)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages)
  #:use-module (gnu services configuration)
  #:use-module (gnu services xorg)
  #:use-module (gnu services)
  #:use-module (gnu system keyboard)
  #:use-module (guix base64)
  #:use-module (guix build-system copy)
  #:use-module (guix channels)
  #:use-module (guix derivations)
  #:use-module (guix download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix modules)
  #:use-module (guix monads)
  #:use-module (guix packages)
  #:use-module (guix records)
  #:use-module (guix store)
  #:use-module (guixrus home services mako)
  #:use-module (ice-9 hash-table)
  #:use-module (ice-9 match)
  #:use-module (rde home services wm)
  #:use-module (rde serializers ini))

(define my-layout
  (keyboard-layout "us,cz" ",ucw" #:options
		   '("grp:caps_switch" "grp_led"
		     "lv3:ralt_switch" "compose:rctrl-altgr")))

(define (file-fetch url hash)
  (with-store store
              (run-with-store store
                              (url-fetch url 'sha256 (base64-decode hash)))))

(define wallpaper
  (file-fetch "https://ift.tt/2UDuBqa"
              "i7XCgxwaBYKB7RkpB2nYcGsk2XafNUPcV9921oicRdo="))

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


(define (sway-keyboard-layout layout)
  `(input *
          ((xkb_layout ,(keyboard-layout-name layout))
           (xkb_variant ,(keyboard-layout-variant layout))
           (xkb_options ,(string-join
                          (keyboard-layout-options layout)
                          ",")))))

(define (sway-kbd binds)
  (string-join (listify binds) "+"))
(define (listify k) (if (list? k) k (list k)))
(define (sway-mkbd binds)
  (sway-kbd (cons "$mod" (listify binds))))

(define (sway-serialize-bindings binds schema->bind)
  (map
   (lambda (q) `(bindsym ,(schema->bind (car q))
                    ,@(cdr q)))
   binds))

(define (prefix-exec l)
  (map (lambda (bind) `(,(car bind) ,@(cons 'exec (listify (cadr bind))))) l))

(define (sway-bindings binds)
  (sway-serialize-bindings binds sway-mkbd))

(define (sway-exec-bindings binds)
  (sway-serialize-bindings
   (prefix-exec binds)
   sway-mkbd))

(define (sway-exec-bindings/nomod binds)
  (sway-serialize-bindings (prefix-exec binds) sway-kbd))

(define (sway-bindings/nomod binds)
  (sway-serialize-bindings binds sway-kbd))

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
              (url "https://git.sr.ht/~michal_atlas/guix-channel")
              (introduction
               (make-channel-introduction
                "f0e838427c2d9c495202f1ad36cfcae86e3ed6af"
                (openpgp-fingerprint
                 "D45185A2755DAF831F1C3DC63EFBF2BBBB29B99E"))))
             (channel
              (name 'guix-gaming-games)
              (url "https://gitlab.com/guix-gaming-channels/games.git")
              (introduction
               (make-channel-introduction
                "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
                (openpgp-fingerprint
                 "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))
             (channel
              (name 'rde)
              (url "https://git.sr.ht/~abcdw/rde")
              (introduction
               (make-channel-introduction
                "257cebd587b66e4d865b3537a9a88cccd7107c95"
                (openpgp-fingerprint
                 "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
             (channel
              (name 'beaver-labs)
              (url "https://gitlab.com/edouardklein/guix")
              (branch "beaverlabs"))
             %default-channels))
   (service home-sway-service-type
            (home-sway-configuration
             (config
              `((set $mod "Mod4")

                ,(sway-keyboard-layout my-layout)
                (input type:keyboard ((xkb_numlock enabled)))

                (gaps inner 5)
                (gaps outer 5)

                (input "1739:32382:DELL0740:00_06CB:7E7E_Touchpad"
                       ((dwt enabled)
                        (tap enabled)
                        (natural_scroll enabled)
                        (middle_emulation enabled)))

                (output "*"
                        ((bg ,wallpaper fill)))

                (output "HDMI-A-1"
                        ((position "1920,0")))
                (output "DP-1"
                        ((position "0,0")))
                ,@(sway-exec-bindings
                   `(("y" ,(file-append foot "/bin/foot unison"))
                     ("Return" ,(file-append emacs-next-pgtk "/bin/emacsclient -c"))
                     ("d" ,(file-append bemenu "/bin/bemenu-run"))
                     ("t" ,(file-append foot "/bin/foot"))
                     (("Shift" "e") "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'")
                     (("Shift" "s")
                      ("DIM=\"$("
                       ,(file-append slurp "/bin/slurp")
                       ")\"" "&&"
                       ,(file-append grim "/bin/grim")
                       "~/tmp/$(date +'%s_grim.png') -g \"$DIM\"" "&&"
                       ,(file-append grim "/bin/grim")
                       "-g \"$DIM\" - |"
                       ,(file-append wl-clipboard "/bin/wl-copy")
                       "--type image/png"))))
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
                  (swaybar_command waybar)))

                (exec swayidle)
                (exec ,(file-append i3-autotiling "/bin/autotiling"))
                (exec ,(file-append mako "/bin/mako"))))))

   (.service home-swayidle
             (config
              `((timeout 1200 "'swaymsg \"output * dpms off\"'"
                         resume "'swaymsg \"output * dpms on\"'")
                (before-sleep "'swaylock'"))))

   (.service home-swaylock
             (config
              `((color . "000000"))))

   (.service home-mako
             (sections
              (list
               (home-mako-section
                (default-timeout 10000)
                (max-visible 10)))))

   (.service home-dbus)

   (.service home-waybar
             (config
              #(((ipc . #t)
                 (id . 0)
                 (modules-left . #("sway/workspaces" "sway/mode"))
                 (modules-center . #("sway/window"))
                 (modules-right . #("idle_inhibitor" "pulseaudio" "network"
                                    "cpu" "memory" "disk" "backlight" "battery"
                                    "clock" "tray"))
                 (idle_inhibitor . ((format . "{icon}")
                                    (format-icons . ((activated . "")
                                                     (deactivated . "")))))
                 (disk . ((format . "{used}/{total}")))
                 (tray . ((spacing . 10)))
                 (pulseaudio . ((format . "{volume}% ")
                                (format-muted . "--% ")
                                (on-click . "swaymsg exec pavucontrol")))
                 (network . ((format-wifi . "{essid} {ipaddr}/{cidr}")
                             (format-ethernet . "{ipaddr}/{cidr}")
                             (tooltip-format . "{signalStrength}%")))
                 (clock . ((format . "{:%FT%TZ}")))
                 (cpu . ((format . "{usage}% ")))
                 (memory . ((format . "{}% ")))
                 (battery . ((format . "{}% BAT")))
                 (backlight . ((format . "{percent}% "))))))
             (style-css `((* ((font-size . 13px)
                              (font-family . monospace)))
                          (window#waybar
                           ((background-color . #{rgba(0,0,0,0)}#)))
                          (label
                           ((background . #{#292b2e}#)
                            (color . #{#fdf6e3}#)
                            (margin . #{0 1px}#)
                            (padding . 5px)
                            (border-left 2px solid grey)
                            (border-right 2px solid grey)))
                          (#{#workspaces}#
                           ((background . #{#1a1a1a}#)))
                          ((#{#workspaces}# button)
                           ((padding 0 2px)
                            (color . #{#fdf6e3}#)))
                          ((#{#workspaces}# button.focused)
                           ((color . #{#268bd2}#)))
                          (#{#pulseaudio}# ((color . #{#268bd2}#)))
                          (#{#memory}# ((color . #{#2aa198}#)))
                          (#{#cpu}# ((color . #{#6c71c4}#)))
                          (#{#battery}# ((color . #{#859900}#)))
                          (#{#disk}# ((color . #{#b58900}#))))))

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
             (config
              `((user
                 ((name . "Michal Atlas")
                  (email . "michal_atlas+git@posteo.net")
                  (signingkey . "3EFBF2BBBB29B99E")))
                (commit
                 ((gpgsign . #t)))
                (sendemail
                 ((smtpserver . "posteo.de")
                  (smtpserverport . 587)
                  (smtpencryption . "tls")
                  (smtpuser . ,(string-append
                                "michal_atlas"
                                "@"
                                "posteo.net")))))))

   (+service home-files
             ;; local-file being explicit allows earlier check for file existence
             `((".emacs.d/init.el" ,(local-file "files/emacs.el"))
               (".config/foot/foot.ini"
                (apply mixed-text-file "foot.ini"
                       (serialize-ini-config
                        `((main
                           ((font . #{Fira Code:size=12}#)
                            (include . ,(file-append
                                         foot
                                         "/share/foot/themes/monokai-pro"))))))))
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
         ("MOZ_USE_XINPUT2" . "1")
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
