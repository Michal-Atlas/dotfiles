(in-package :stumpwm)
(setf *default-package* :stumpwm)

(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-battery-portable/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-winner-mode/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-swm-gaps/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-screenshot/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-pass/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-pamixer/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-numpad-layouts/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-notify/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-kbd-layouts/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-disk/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-battery-portable/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-globalwindows/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-wifi/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-ttf-fonts/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-stumptray/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-net/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-mem/")
(add-to-load-path #p"/run/current-system/profile/share/common-lisp/sbcl/stumpwm-cpu/")

(add-to-load-path #p"/home/michal_atlas/.guix-profile/share/common-lisp/sbcl/zpng/")
(add-to-load-path #p"/home/michal_atlas/.guix-profile/share/common-lisp/sbcl/salza2/")

;; (setf *altgr-offset* 4)

;; (run-shell-command "xmodmap -e 'clear mod4'" t)
;; (run-shell-command "xmodmap -e 'add mod4 = Super_L'" t)
;; (stumpwm:set-prefix-key (stumpwm:kbd "F20"))
(stumpwm:set-prefix-key (stumpwm:kbd "C-z"))

;; (load-module :stumptray)
(load-module :battery-portable)
;; (load-module "mode-line")
;; (load-module "stump-backlight")
;; (load-module "battery-portable")
;; (load-module "swm-gaps")

(setf *mouse-focus-policy* :sloppy
      *float-window-modifier* :SUPER
      ;; *mode-line-timeout* 5
      ;; *time-modeline-string* "%F %H:%M"
      ;; *group-format* "%t"
      ;; *window-format* "%n: %30t"
      ;; *mode-line-formatter-list* '(("%g") ("%w") ("^>") ("%B") ("%d"))
      ;; swm-gaps:*inner-gaps-size* 5
      )

;; (when *initializing* (swm-gaps:toggle-gaps))

(when *initializing*
  (mode-line)
  (which-key-mode)
  (run-commands
   "exec feh --bg-center /home/michal_atlas/Documents/Wallpapers/wallpaper.png"
   "gkill Default"
   "gnew-dynamic Alpha"
   "gnew-dynamic Lambda"
   "gnew-dynamic Fire")
  (loop for i from 0 to 9 do
	(define-key *top-map*
	    (kbd (concatenate 'string "s-" (format nil "~a" i)))
	  (concatenate 'string "gselect " (format nil "~a" i)))))

(defcommand firefox () ()
	    "Run or raise Firefox."
	    (sb-thread:make-thread (lambda () (run-or-raise "firefox" '(:class "Firefox") t nil))))

;; (defcommand delete-window-and-frame () ()
;;   "Delete the current frame with its window."
;;   (delete-window)
;;   (remove-split))

;; (defcommand hsplit-and-focus () ()
;;   "Create a new frame on the right and focus it."
;;   (hsplit)
;;   (move-focus :right))

;; (defcommand vsplit-and-focus () ()
;;   "Create a new frame below and move focus to it."
;;   (vsplit)
;;   (move-focus :down))

(defcommand term (&optional program) ()
  "Invoke a terminal, possibly with a @arg{program}."
  (sb-thread:make-thread
   (lambda ()
     (run-shell-command (if program
                            (format nil "kitty ~A" program)
                            "kitty")))))

(defcommand dmenu-run () ()
	    (sb-thread:make-thread
	     (lambda ()
	       (run-shell-command "dmenu_run"))))

(define-key *top-map* (kbd "s-d") "dmenu-run")
(define-key *top-map* (kbd "s-t") "term")
(define-key *root-map* (kbd "m") "mode-line")

(define-key *top-map* (kbd "s-f") "firefox")
(define-key *top-map* (kbd "s-Left") "prev")
(define-key *top-map* (kbd "s-Right") "next")

;; Gapps

(load-module "swm-gaps")
(load-module "net")
(setf swm-gaps:*inner-gaps-size* 13
      swm-gaps:*outer-gaps-size* 7
      swm-gaps:*head-gaps-size* 0)
(when *initializing*
  (swm-gaps:toggle-gaps))
(define-key *groups-map* (kbd "g") "toggle-gaps")

;; Modeline
(when *initializing*
  (defconstant backlightfile "/sys/class/backlight/intel_backlight/brightness"))
(load-module "pamixer")
(setf *time-modeline-string* "%a, %b %d %I:%M%p"
      *screen-mode-line-format*
      (list
       ;; Groups
       " ^7[^B^4%n^7^b] "
       ;; Pad to right
       "^>"
       ;; Date
       "^7"
       "%d"
       ;; Battery
       " ^7[^n%B^7]^n "
       "| %l "
       "| %P "
       "| "
       '(:eval (get-backlight-num))))

(defun get-backlight-num ()
  (format nil "~a"
	  (/ (parse-integer
	      (string-trim " \n"
	       (uiop:read-file-string backlightfile)))
	     100.0)))

(define-key *root-map* (kbd "C-q") "send-raw-key")

;; ShowNet

(defcommand show-net () ()
	    (message
	     (uiop:run-program
	      (list "ip" "addr")
	      :output :string)))

(define-key *root-map* (kbd "N") "show-net")
(define-key *root-map* (kbd "e") "exec emacsclient -nc")

(define-key *top-map* (kbd "XF86AudioRaiseVolume") "pamixer-volume-up")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "pamixer-volume-down")
(define-key *top-map* (kbd "XF86AudioMute") "pamixer-toggle-mute")

(define-key *top-map* (kbd "XF86MonBrightnessUp") "exec light -A 10")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "exec light -U 10")
(define-key *top-map* (kbd "XF86AudioPrev") 
  "exec playerctl previous")
(define-key *top-map* (kbd "XF86AudioNext") 
  "exec playerctl next")
(define-key *top-map* (kbd "XF86AudioPlay") 
  "exec playerctl play-pause")

(defconstant *book-dir* "/home/michal_atlas/Documents/Books/")
(defcommand open-book () ()
	    (let ((book 
		   (completing-read
		    (current-screen)
		    "Which Book?: "
		    (mapcar
		     #'pathname-name
		     (directory
		      #p"/home/michal_atlas/Documents/Books/*.pdf")))))
	      (sb-thread:make-thread
	       (lambda ()
		 (run-shell-command
		  (list "okular"
			(concat 'string
				#p"/home/michal_atlas/Documents/Books/" book ".pdf")))))))

(define-key *root-map* (kbd "B") "open-book")

(load-module "screenshot")

(defcommand scrt-datewrap (&optional area) ((:rest "Area?: "))
	    (let ((f (if (equal area "t")
			 #'screenshot:screenshot-area
			 #'screenshot:screenshot)))
	      (funcall f (format nil "~~/tmp/shot-~a.png"
				 (get-universal-time)))))

(define-key *top-map* (kbd "s-S") "scrt-datewrap t")
(define-key *top-map* (kbd "s-s") "scrt-datewrap n")
