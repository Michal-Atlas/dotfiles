;; Imports

;; [[file:Dotfiles.org::*Imports][Imports:1]]
(use-modules
 (gnu home)
 (gnu home services)
 (gnu home services shells)
 (gnu home services shepherd)
 (gnu home services ssh)
 (gnu home services fontutils)
 (gnu home services guix)
 (gnu home services desktop)
 (gnu services)
 (gnu packages)
 (gnu packages base)
 (gnu packages admin)
 (gnu packages emacs)
 (gnu packages password-utils)
 (gnu packages wm)
 (gnu packages xdisorg)
 (gnu packages python-xyz)
 (gnu packages freedesktop)
 (gnu packages shellutils)
 (gnu services xorg)
 (gnu packages mpd)
 (gnu packages music)
 (gnu packages linux)
 (gnu packages terminals)
 (gnu packages lisp)
 (gnu packages curl)
 (gnu packages ocaml)
 (gnu home services mcron)
 (ice-9 hash-table)
 (gnu system keyboard)
 (guix gexp)
 (guix base64)
 (guix download)
 (guix channels)
 (guix modules)
 (guix monads)
 (guix store)
 (guix derivations)
 (ice-9 match)
 (gnu packages gnome)
 (guix packages)
 (guix build-system copy)
 (guix download)
 (gnu services configuration)
 (gnu packages package-management)
 (guix records)
 (gnu packages image)
 (guixrus home services emacs)
 (atlas home services sway)
 (atlas home services git)
 (atlas home services flatpak))
;; Imports:1 ends here

(define my-layout
  (keyboard-layout "us,cz" ",ucw" #:options
		   '("grp:caps_switch" "grp_led"
		     "lv3:ralt_switch" "compose:rctrl-altgr")))

;; Custom Services

;; [[file:Dotfiles.org::*Custom Services][Custom Services:1]]
(define (file-fetch url hash)
  (with-store store
              (run-with-store store
                              (url-fetch url 'sha256 (base64-decode hash)))))
;; Custom Services:1 ends here

(define rsync-dirs '("Sync" "cl" "Documents" "Zotero"))
(define rsync-target
  (assoc-ref
   `(("hydra" . "dagon.local")
     ("dagon" . "hydra.local"))
   (vector-ref (uname) 1)))

;; Home Environment

;; [[file:Dotfiles.org::*Home Environment][Home Environment:1]]
(home-environment
 (services
  (list   
   (service home-sway-service-type
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
                
              (set $sock "$XDG_RUNTIME_DIR/wob.sock")
              (exec "rm -f" $sock
                    "&& mkfifo" $sock "&& tail -f" $sock
                    "|"
                    ,(file-append wob "/bin/wob"))

              (exec swaync)
                
              ,@(sway-exec-bindings
                 `(("Return" ,(file-append emacs-next-pgtk "/bin/emacsclient -c"))
                   ("d" ,(file-append bemenu "/bin/bemenu-run"))
                   ("t" ,(file-append kitty "/bin/kitty"))
                   (("Shift" "e") "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'")
                   (("Shift" "s")
                    "DIM=\"$(" ,(file-append slurp "/bin/slurp") "\""
                    " && " ,(file-append grim "/bin/grim")
                    " ~/tmp/$(date +'%s_grim.png') -g \"$DIM\" "
                    "&& " ,(file-append grim "/bin/grim")
                    " -g \"$DIM\" - | wl-copy --type image/png")))
              ,@(sway-exec-bindings/nomod
                 `(("XF86AudioPrev" ,(file-append playerctl "/bin/playerctl previous"))
                   ("XF86AudioNext" ,(file-append playerctl "/bin/playerctl next"))
                   ("XF86AudioPlay" ,(file-append playerctl "/bin/playerctl play-pause"))
                   ("XF86AudioRaiseVolume" 
                    "pactl set-sink-volume @DEFAULT_SINK@ +5% && pactl get-sink-volume @DEFAULT_SINK@ | head -n 1| awk '{print substr($5, 1, length($5)-1)}' > $sock")
                     
                   ("XF86AudioLowerVolume" "pactl set-sink-volume @DEFAULT_SINK@ -5% && pactl get-sink-volume @DEFAULT_SINK@ | head -n 1| awk '{print substr($5, 1, length($5)-1)}' > $sock")
                   ("XF86AudioMute" "pactl set-sink-mute @DEFAULT_SINK@ toggle && pactl get-sink-mute @DEFAULT_SINK@ | grep \"no\" && echo 100 > $sock || echo 0 > $sock")
                   ("XF86AudioMicMute" "pactl set-source-mute @DEFAULT_SOURCE@ toggle")

                   ("XF86MonBrightnessUp"
                    ,(file-append brightnessctl "/bin/brightnessctl +10%"))
                   ("XF86MonBrightnessDown"
                    ,(file-append brightnessctl "/bin/brightnessctl 10%-"))))
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
   (service home-shepherd-service-type
	    (home-shepherd-configuration
	     (services
              ((if (string= "hydra" (vector-ref (uname) 1))
                   (lambda (q) (cons
                           (shepherd-service
                            (provision '(unison))
                            (start #~(make-forkexec-constructor
                                      (list #$(file-append unison "/bin/unison"))))
                            (stop #~(make-kill-destructor)))
                           q))
                   identity)
	       (list
	        (shepherd-service
		 (provision '(disk-automount))
		 (start #~(make-forkexec-constructor
			   (list #$(file-append udiskie "/bin/udiskie"))))
		 (stop #~(make-kill-destructor))))))))
   ;; Home Environment:1 ends here

   ;; Mcron


   ;; [[file:Dotfiles.org::*Mcron][Mcron:1]]
   (service
    home-mcron-service-type
    (home-mcron-configuration
     (jobs
      (list
       #~(job "0 * * * *"
	      (string-append 
	       #$(file-append findutils "/bin/find")
	       " ~/tmp/ ~/Downloads/ -mindepth 1 -mtime +2 -delete;"))
       #~(job "0 * * * *"
	      "guix gc -F 20G")))))

   (service home-git-service-type
            (home-git-configuration
             (name "Michal Atlas")
             (email "michal_atlas+git@posteo.net")))
   ;; Mcron:1 ends here

   ;; [[file:Dotfiles.org::*Mcron][Mcron:2]]
   (simple-service
    'dotfiles
    home-files-service-type
    ;; local-file being explicit allows earlier check for file existencex
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
                         "batch=true\n"
                         "log=true\n"
                         "repeat=watch\n"
                         "sortbysize=true\n"))))
   
   (service
    home-bash-service-type
    (home-bash-configuration
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
     ;; Mcron:2 ends here

     ;; Aliases

     ;; [[file:Dotfiles.org::*Aliases][Aliases:1]]
     (aliases `
      (("gx" . "guix") ("gxi" . "gx install")
       ("gxb" . "gx build") ("gxs" . "gx search")
       ("gxsh" . "gx shell") ("gxtm" . "gx time-machine")
       ("e" . "$EDITOR") ("sw" . "swayhide")
       ("cat" . "bat -p")
       ("recon-home" . "guix home reconfigure $HOME/cl/dotfiles/home.scm")
       ("recon-system" . "sudo guix system reconfigure $HOME/cl/dotfiles/system.scm")
       ("recon-home-time" . "guix time-machine -C $HOME/.guix-home/channels.scm -- home reconfigure $HOME/cl/dotfiles/home.scm")
       ("recon-system-time" . "sudo guix time-machine -C /run/current-system/channels.scm -- system reconfigure $HOME/cl/dotfiles/system.scm")
       ("dd" . "dd status=progress")))
     ;; Aliases:1 ends here

     ;; Environment

     ;; [[file:Dotfiles.org::*Environment][Environment:1]]
     (environment-variables `
      (("BROWSER" . "firefox") ("EDITOR" . "emacsclient -n -c")
       ("TERM" . "xterm-256color") ("MOZ_ENABLE_WAYLAND" . "1")
       ("MOZ_USE_XINPUT2" . "1") ("GRIM_DEFAULT_DIR" . "~/tmp")
       ("_JAVA_AWT_WM_NONREPARENTING" . "1")
       ("PATH" . "$HOME/.nix-profile/bin/:$PATH")
       ("PATH" . "$PATH:$HOME/bin/")
       ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/bin")
       ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/dotfiles")
       ("GUIX_SANDBOX_HOME" . "/GAMES")
       ("ALTERNATE_EDITOR" . ""))
      )
     ;; Environment:1 ends here

     ;; [[file:Dotfiles.org::*Environment][Environment:2]]
     ))
   ;; Environment:2 ends here

   ;; [[file:Dotfiles.org::*Environment][Environment:3]]
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

   ;; Environment:3 ends here

   (service home-flatpak-service-type
            (home-flatpak-configuration
             (packages
              '(("flathub"
                 "com.discordapp.Discord"
                 "org.telegram.desktop"
                 "org.zotero.Zotero"
                 "com.spotify.Client")))))

   ;; [[file:Dotfiles.org::*Environment][Environment:4]]
   ;; (service home-provenance-service-type)
   (service home-openssh-service-type
	    (home-openssh-configuration
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
                                    (local-file "keys/arc.pub")))))
   ;; Environment:4 ends here

   ;; [[file:Dotfiles.org::*Environment][Environment:5]]
   )))
;; Environment:5 ends here
