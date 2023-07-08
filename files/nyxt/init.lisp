(defmethod customize-instance ((input-buffer input-buffer) &key)
  (disable-modes* 'nyxt/mode/vi:vi-normal-mode input-buffer)
  (enable-modes* 'nyxt/mode/emacs:emacs-mode input-buffer))
(defmethod customize-instance ((browser browser) &key)
  (setf (slot-value browser 'theme) theme:+dark-theme+))