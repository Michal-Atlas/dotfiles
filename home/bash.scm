(define-module (home bash)
  #:use-module (atlas utils services)
  #:use-module (gnu home services shells)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (gnu packages base)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages rdesktop)
  #:export (bash))

(define bash
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
       (mixed-text-file
        "bashrc-zoxide"
        "eval \"$(" (file-append zoxide "/bin/zoxide") " init bash --cmd cd)\"")
       (mixed-text-file
        "bashrc-direnv"
        "eval \"$(" (file-append direnv "/bin/direnv") " hook bash)\"")
       (mixed-text-file
        "bashrc-fzf-history"
        ". "
        (origin
          (method url-fetch)
          (uri "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash")
          (sha256 (base32 "0s078va037r0pdjr7f50x7ksjppp63sqxxgzv8wxamvvhvlly251"))))
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
        (file-append bat "/bin/bat")
        " -pl lisp; }")
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
        ("sw" . "swayhide")
        ("cat" . "bat -p")
        ("shen-scheme" . "rlwrap shen-scheme")
        ("u" . "unison")))))
