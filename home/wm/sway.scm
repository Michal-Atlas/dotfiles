(define-module (home wm sway)
  #:use-module (gnu system keyboard)
  #:use-module (engstrand wallpapers)
  #:use-module (atlas utils services)
  #:use-module (gnu home-services wm)
  #:use-module (guix gexp)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages image)
  #:use-module (gnu packages music)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xorg)
  #:export (wm:sway))

(define* (klayout #:key (layout "us,cz,ru"))
  (keyboard-layout layout ",ucw" #:options
		   '("grp:caps_switch" "grp_led"
		     "lv3:ralt_switch" "compose:rctrl-altgr")))

(define (sway-keyboard-layout . rest)
  "Takes a standard guix keyboard-layout object
and emits a Sway input config
compatible with the RDE sway service."
  (let ((layout (apply klayout rest)))
    `(input type:keyboard
            ((xkb_layout ,(keyboard-layout-name layout))
             (xkb_variant ,(keyboard-layout-variant layout))
             (xkb_options ,(string-join
                            (keyboard-layout-options layout)
                            ","))))))

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

(define (sway-exec-bindings/nomod binds)
  (sway-serialize-bindings (prefix-exec binds) sway-kbd))

(define (sway-bindings/nomod binds)
  (sway-serialize-bindings binds sway-kbd))

(define (sway-bindings binds)
  "Takes a list of binds and commands,
and emits an RDE sway service compatible set of binds.
if the command requires multiple keys,
the car should be a list of all the keys:

@lisp
(\"s\" \"foobar\")
@end lisp

emits something that if ran through RDE sway
will produce:

@example
bindsym $mod+s foobar
@end example

the form is very forgiving and
the cdr may also be a file-like

@lisp
((\"Shift\" \"s\")
 (\"ls\"
  ,(file-append grim \"/bin/grim\")))
@end lisp

so rde will produce

@example
bindsym $mod+Shift+s ls /gnu/store/.../bin/grim
@end example

to not automatically prepend $mod see the /nomod variant"
  (sway-serialize-bindings binds sway-mkbd))

(define (sway-exec-bindings binds)
  "Like sway-bindings but prefixes
exec to all your commands"
  (sway-serialize-bindings
   (prefix-exec binds)
   sway-mkbd))


(define bemenu-flags
  (list
   "-c"
   "-M200"
   "--fn 'Fira Code 15'"
   "-B2"
   "-l10"))

(define wallpaper
  (get-wallpaper-path "neon/china-reflection.jpg"))

(define wm:sway
 (&s home-sway
     (config
      `((set $mod "Mod4")
        ,(sway-keyboard-layout)
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
           `(("Return" ,(file-append emacs-pgtk "/bin/emacsclient -c"))
             ("d" ,(file-append bemenu (string-join
                                        (cons
                                         "/bin/bemenu-run"
                                         bemenu-flags))))
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
               "--type image/png"))
             ("l" "swaylock")))
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
                    (iota 10))
             ,@(map (compose (lambda (q) `(("Shift" ,q)
                                      ,(string-append "move container to workspace number " q)))
                             number->string)
                    (iota 10))
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

        (bindcode "Ctrl+49" input "*" xkb_switch_layout next)

        (exec ,(file-append xhost "/bin/xhost +si:localuser:root"))
        (exec swayidle)
        (exec ,(file-append i3-autotiling "/bin/autotiling"))
        (exec ,(file-append mako "/bin/mako"))))))
