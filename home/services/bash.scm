(define-library (home services bash)
  (import (scheme base)
          (atlas utils services)
          (atlas utils download)
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
            (plain-file "bashrc-ignoredups" "export HISTCONTROL=ignoredups")
            (mixed-text-file "bashrc-run"
		             "function run { "
		             guix "/bin/guix"
		             " shell $1 -- $@; }")
            (mixed-text-file "bashrc-valgrind"
		             "alias valgrind=\""
		             guix "/bin/guix"
		             " shell -CF valgrind -- valgrind \"")
            (mixed-text-file "bashrc-cheat"
		             "function cheat { "
		             curl "/bin/curl"
		             " \"cheat.sh/$@\"; }")
            (let* ((default-color "\\[\\e[0m\\]")
                   (color
                    (lambda (color text)
                      (string-append
                       (case color
                         ((red) "\\[\\e[91m\\]")
                         ((blue) "\\[\\e[96m\\]")
                         ((pink) "\\[\\e[95m\\]")
                         ((salmon) "\\[\\e[38;5;218m\\]")
                         ((green) "\\[\\e[92m\\]"))
                       text default-color)))
                   (hostname "\\H")
                   (pwd "\\w")
                   (exit-status "$?")
                   (jobs "\\j")
                   (prompt "\\$")
                   (git-branch "$(git branch 2>/dev/null | grep '\"'\"'*'\"'\"' | colrm 1 2)"))
              (mixed-text-file
               "bashrc-ps1"
               "PS1='\\n\\n"
               (color 'red hostname) "@" (color 'blue pwd) "\\n"
               "[" (color 'pink exit-status) "] {"
               (color 'salmon jobs) "} " (color 'green git-branch)
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
             ("cat" . "bat -p")))

          (environment-variables
           `(("BROWSER" . "firefox") ("EDITOR" . "emacsclient")
             ("TERM" . "xterm-256color") ("MOZ_ENABLE_WAYLAND" . "1")
             ("MOZ_USE_XINPUT2" . "1")
             ("_JAVA_AWT_WM_NONREPARENTING" . "1")
             ("PATH" . "$HOME/.nix-profile/bin/:$PATH")
             ("GUIX_SANDBOX_HOME" . "$HOME/Games")
             ("ALTERNATE_EDITOR" . "")))))))
