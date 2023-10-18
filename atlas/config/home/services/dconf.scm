(define-module (atlas config home services dconf)
  #:use-module (guix gexp)
  #:use-module (atlas combinators)
  #:use-module (atlas utils download)
  #:use-module (atlas home services dconf))

(define (keybinds binds)
  (define prefix "org/gnome/settings-daemon/plugins/media-keys")
  (define (bind->ini name binding command)
    `(,(string-append prefix "/custom-keybindings/" name)
      (name ,name)
      (binding ,binding)
      (command ,command)))
  `((,prefix
     (custom-keybindings
      ,(list->vector
	(map
	 (lambda (bind)
           (string-append "/" prefix "/custom-keybindings/" (car bind) "/"))
	 binds))))
    ,@(map (lambda (bind) (apply bind->ini bind))
	   binds)))

(define-public %dconf
  (hm/&s home-dconf-load #:config
         #~`(("org/gnome/shell"
	      (disable-user-extensions #f)
	      (enabled-extensions
	       #("launch-new-instance@gnome-shell-extensions.gcampax.github.com"
	         "drive-menu@gnome-shell-extensions.gcampax.github.com"
	         "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
	         "appindicatorsupport@rgcjonas.gmail.com"
	         "nightthemeswitcher@romainvigier.fr"
	         "gnome-extension-all-ip-addresses@havekes.eu"
	         "color-picker@tuberry"
	         "espresso@coadmunkee.github.com"
                 "sound-output-device-chooser@kgshank.net"
	         "gnome-clipboard@b00f.github.io")))
	     ("org/gnome/desktop/peripherals/touchpad"
	      (tap-to-click #t))

	     #$@(keybinds
	         `(("TERM" "<Super>t" "kgx")
		   ("EMACS" "<Super>Return" "emacsclient -c")
		   ("FILES" "<Super>n" "nautilus")))

             ("org/gnome/shell/extensions/nightthemeswitcher/time"
              ("always-enable-ondemand" #t))

	     ("org/gnome/desktop/background"
	      (picture-uri
	       #$(file-fetch
	          "https://www.gnu.org/graphics/o_espirito_da_liberdade.fondo.big.png"
                  "/FtzhvBt3Zd6gggudAgg9oiv89osXN44E9qJrzVa+EY="))
	      (picture-uri-dark
	       #$(file-fetch
	          "https://www.gnu.org/graphics/techy-gnu-tux-bivouac-large.jpg"
	          "oOYE1PZ1g2HvXqUbL5aE3xkW+SqkKPmO0GaVI9QlI40=")))
             ("org/gnome/desktop/background"
              (picture-options "scaled"))

             ("org/gnome/desktop/input-sources"
              (sources #(("xkb" "us") ("xkb" "cz+ucw")))
              (xkb-options #("grp:caps_switch" "lv3:ralt_switch"
                             "compose:rctrl-altgr")))

             ("org/gnome/system/location"
              (enabled #t))

             ("org/gnome/shell/extensions/nightthemeswitcher/time"
              (manual-schedule #f))

             ("org/gnome/desktop/wm/preferences"
              (focus-mode "sloppy"))

             ("org/gnome/settings-daemon/plugins/color"
              (night-light-enabled #t))

             ("org/gnome/shell"
              (favorite-apps
               #("firefox.desktop"
                 "spotify.desktop"
                 "discord.desktop"
                 "org.keepassxc.KeePassXC.desktop"
                 "fi.skyjake.Lagrange.desktop"
                 "zotero.desktop"
                 "org.gnome.Nautilus.desktop")))

             ("org/gnome/mutter"
              (edge-tiling #t)
              (dynamic-workspaces #t)
              (workspaces-only-on-primary #t))

             ("org/gnome/shell/app-switcher"
              (current-workspace-only #t))

             ("org/gnome/shell"
              (disable-user-extensions #f)
              (enabled-extensions
               #("drive-menu@gnome-shell-extensions.gcampax.github.com"
                 "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
                 "nightthemeswitcher@romainvigier.fr"
                 "gnome-extension-all-ip-addresses@havekes.eu"
                 "color-picker@tuberry"
                 "espresso@coadmunkee.github.com"
                 "gnome-clipboard@b00f.github.io"
                 "apps-menu@gnome-shell-extensions.gcampax.github.com"
                 "blur-my-shell@aunetx"
                 "clipboard-indicator@tudmotu.com"
                 "appindicatorsupport@rgcjonas.gmail.com"
                 "gsconnect@andyholmes.github.io"
                 "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
                 "native-window-placement@gnome-shell-extensions.gcampax.github.com"
                 "noannoyance@daase.net"
                 "Vitals@CoreCoding.com"))))))