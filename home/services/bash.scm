(define-library (home services bash)
  (import (scheme base)
          (atlas utils services)
          (gnu home services shells)
          (guix gexp)
          (gnu packages shellutils)
          (gnu packages package-management)
          (gnu packages admin)
          (gnu packages curl))
  (export %bash)
  (begin
    (define %bash
      (&s home-bash
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
            ("ipfs" . "sudo -u ipfs bash --login")
            ("sw" . "swayhide")
            ("cat" . "bat -p")
            ("recon-home" . "guix home reconfigure $HOME/cl/dotfiles/home.scm")
            ("recon-system" . "sudo guix system reconfigure $HOME/cl/dotfiles/system.scm")
            ("recon-home-time" . "guix time-machine -C $HOME/.guix-home/channels.scm -- home reconfigure $HOME/cl/dotfiles/home.scm")
            ("recon-system-time" . "sudo guix time-machine -C /run/current-system/channels.scm -- system reconfigure $HOME/cl/dotfiles/system.scm")))

          (environment-variables
           `(("BROWSER" . "firefox") ("EDITOR" . "emacsclient")
             ("TERM" . "xterm-256color") ("MOZ_ENABLE_WAYLAND" . "1")
             ("MOZ_USE_XINPUT2" . "1")
             ("_JAVA_AWT_WM_NONREPARENTING" . "1")
             ("PATH" . "$HOME/.nix-profile/bin/:$PATH")
             ("PATH" . "$PATH:$HOME/bin/")
             ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/bin")
             ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/dotfiles")
             ("GUIX_SANDBOX_HOME" . "$HOME/Games")
             ("ALTERNATE_EDITOR" . "")))))))
