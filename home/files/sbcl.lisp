(require 'asdf)

(asdf:initialize-source-registry
 `(:source-registry
   (:directory "~/cl/link-farm")
   :inherit-configuration))

(require 'linedit)

;;; Check for --no-linedit command-line option.
(if (member "--no-linedit" sb-ext:*posix-argv* :test 'equal)
    (setf sb-ext:*posix-argv*
          (remove "--no-linedit" sb-ext:*posix-argv* :test 'equal))
    (when (interactive-stream-p *terminal-io*)
      (linedit:install-repl :wrap-current t :eof-quits t)
      (funcall (intern "INSTALL-REPL" :linedit) :wrap-current t)))

