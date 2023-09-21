(define-library (home services bash)
  (import (scheme base)
          (utils services)
          (utils download)
          (gnu home services shells)
          (guix gexp)
          (gnu packages base)
          (gnu packages shellutils)
          (gnu packages package-management)
          (gnu packages admin)
          (gnu packages curl)
          (gnu packages version-control))
  (export %bash)
  (begin
    (define system-repo "$HOME/cl/dotfiles")
    (define %bash
      (&s home-bash
          (guix-defaults? #t)
          (bashrc
           (list
            (mixed-text-file "tinker"
                             "function tinker { "
                             "DIR=\"$(" coreutils "/bin/mktemp -d)\";"
                             git "/bin/git clone \"$1\" \"$DIR\";"
                             "cd \"$DIR\";"
                             " }")
            (mixed-text-file "bashrc-direnv"
		             "eval \"$("
		             direnv "/bin/direnv"
		             " hook bash)\"")
            (mixed-text-file "bashrc-fzfbind"
                             ". "
                             (file-fetch
                              "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash"
                              "0qGJBDRM/kW/eNKkNyEw/36pc5D7/cPENzEeb49NhNU="))
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
		             " \"cheat.sh/$@\"; }")
            (let* ((default-color "\\[\\e[0m\\]")
                   (color-fn
                    (lambda (color)
                      (lambda (text)
                        (string-append color text default-color))))
                   (color-red (color-fn "\\[\\e[91m\\]"))
                   (color-blue (color-fn "\\[\\e[96m\\]"))
                   (color-pink (color-fn "\\[\\e[95m\\]"))
                   (color-salmon (color-fn "\\[\\e[38;5;218m\\]"))
                   (color-green (color-fn "\\[\\e[92m\\]"))
                   (hostname "\\H")
                   (pwd "\\w")
                   (exit-status "$?")
                   (jobs "\\j")
                   (prompt "\\$")
                   (git-branch "$(git branch 2>/dev/null | grep '\"'\"'*'\"'\"' | colrm 1 2)"))
              (mixed-text-file
               "bashrc-ps1"
               "PS1='\\n\\n"
               (color-red hostname) "@" (color-blue pwd) "\\n"
               "[" (color-pink exit-status) "] {"
               (color-salmon jobs) "} " (color-green git-branch)
               "\\n" prompt " "
               "'"))))

          (aliases
           `(("gx" . "guix")
             ("gxi" . "gx install")
             ("gxb" . "gx build")
             ("gxs" . "gx search")
             ("gxsh" . "gx shell")
             ("gxtm" . "gx time-machine")
             ("e" . "$EDITOR")
             ("ipfs" . "sudo -u ipfs bash --login")
             ("sw" . "swayhide")
             ("cat" . "bat -p")
             ("recon-home" .
              ,(string-append "guix home reconfigure " system-repo "/home.scm"))
             ("recon-system" .
              ,(string-append "sudo \"GUILE_LOAD_PATH=$GUILE_LOAD_PATH\" guix system reconfigure " system-repo "/system.scm"))
             ("recon-home-time" .
              ,(string-append "guix time-machine -C $HOME/.guix-home/channels.scm -- home reconfigure " system-repo "/home.scm"))
             ("recon-system-time" .
              ,(string-append "sudo \"GUILE_LOAD_PATH=$GUILE_LOAD_PATH\" guix time-machine -C /run/current-system/channels.scm -- system reconfigure " system-repo "/system.scm"))))

          (environment-variables
           `(("BROWSER" . "firefox") ("EDITOR" . "emacsclient")
             ("TERM" . "xterm-256color") ("MOZ_ENABLE_WAYLAND" . "1")
             ("MOZ_USE_XINPUT2" . "1")
             ("_JAVA_AWT_WM_NONREPARENTING" . "1")
             ("PATH" . "$HOME/.nix-profile/bin/:$PATH")
             ("PATH" . "$PATH:$HOME/bin/")
             ("GUIX_SANDBOX_HOME" . "$HOME/Games")
             ("ALTERNATE_EDITOR" . "")
             ("GUILE_LOAD_PATH" . ,(string-append
                                    system-repo
                                    ":$GUILE_LOAD_PATH"))))))))
