  ;;; The following lines added by ql:add-to-init-file:
  #-quicklisp
  (let ((quicklisp-init (merge-pathnames "cl/setup.lisp"
					 (user-homedir-pathname))))
    (when (probe-file quicklisp-init)
      (load quicklisp-init)))

  (ql:quickload :cffi)

  (setf cffi:*foreign-library-directories* 
	'("/run/current-system/sw/lib"))

  (ql:quickload :linedit)

  ;;; Check for --no-linedit command-line option.
  (if (member "--no-linedit" sb-ext:*posix-argv* :test 'equal)
      (setf sb-ext:*posix-argv* 
	    (remove "--no-linedit" sb-ext:*posix-argv* :test 'equal))
      (when (interactive-stream-p *terminal-io*)
	(linedit:install-repl :wrap-current t :eof-quits t)
	(funcall (intern "INSTALL-REPL" :linedit) :wrap-current t)))