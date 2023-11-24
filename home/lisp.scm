(define-module (home lisp)
  #:use-module (rde home services lisp)
  #:use-module (atlas utils services)
  #:use-module (guix gexp)

  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (atlas packages lisp)
  #:use-module (guix packages)
  #:use-module (gnu home services)
  #:use-module (guix modules)

  #:export (lisp))

(define extra-core-packages
  (list sbcl-linedit))

(define core-generation-script
  (apply mixed-text-file
         "setup.lisp"
         (append
          '("(require 'asdf)\n")
          (map
           (lambda (pkg)
             (format #f "(require '~a)~%"
                     (string-drop (package-name pkg) 5)))
           extra-core-packages)
          '("(save-lisp-and-die (uiop:getenv \"out\"))\n"))))

(define custom-core
  (with-imported-modules (source-module-closure
                          '((guix build asdf-build-system)))
   (computed-file
    "custom.core"
    #~(begin
        ((@@ (guix build asdf-build-system) configure)
         #:inputs (map cons
                       '#$(map package-name extra-core-packages)
                       '#$extra-core-packages))
        (setenv "out" #$output)
        (system* #$(file-append sbcl "/bin/sbcl")
                 "--load" #$core-generation-script)))))

(define lisp
  (list
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
                     "(:directory \"~/cl/link-farm\")"))))
   (+s home-files qcl
       `((".bin/qcl"
          ,(program-file "qcl"
                         #~(apply system*
                                  #$(file-append sbcl "/bin/sbcl")
                                  "--core" #$custom-core
                                  (cdr (command-line)))))))))
