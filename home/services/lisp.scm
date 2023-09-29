(define-module (home services lisp)
  #:use-module (atlas utils services)
  #:use-module (guix gexp)
  #:use-module (rde home services lisp))

(define-public %lisp
  (&s home-lisp
      (sbclrc-lisp
       '((require 'asdf)
         (require 'linedit)

;;; Check for --no-linedit command-line option.
         (if (member "--no-linedit" sb-ext:*posix-argv* :test 'equal)
             (setf sb-ext:*posix-argv*
                   (remove "--no-linedit" sb-ext:*posix-argv* :test 'equal))
             (when (interactive-stream-p *terminal-io*)
               (linedit:install-repl :wrap-current t :eof-quits t)
               (funcall (intern "INSTALL-REPL" :linedit) :wrap-current t)))))
      (extra-source-registry-files
       (list
        (plain-file "link-farm.conf"
                    "(:directory \"~/cl/link-farm\")")))))
