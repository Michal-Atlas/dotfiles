(mapcar #'ql:quickload
        '(:local-time
          :cl-fad
          :osicat))

(defun home/ (dir)
  (uiop:merge-pathnames*
   dir
   (user-homedir-pathname)))

(defvar *tmp-log-dir* (home/ #p"tmp-log/"))

(defvar time-cache nil)
(defun get-time () (or time-cache (setf time-cache (local-time:now))))

(defun make-tmp-path (type)
  (uiop:merge-pathnames*
   (make-pathname
    :directory
    `(:relative
      ,(format nil
               "~a.~a"
               (local-time:format-timestring
                nil (get-time)
                :format local-time:+rfc3339-format/date-only+)
               type)))
   *tmp-log-dir*))

(defun walker (from-dir to-dir)
  (lambda (file)
    (let ((mtime (osicat-posix:stat-mtime (osicat-posix:lstat file)))
          (dest-file (uiop:merge-pathnames*
                      (uiop:enough-pathname file from-dir)
                      to-dir)))
      (when (local-time:timestamp<
             (local-time:unix-to-timestamp mtime)
             (local-time:timestamp- (get-time) 1 :day))
        (ensure-directories-exist dest-file)
        (rename-file file dest-file)))))

(defun delete-empty (dir)
  (when (null (fad:list-directory dir))
    (uiop:delete-empty-directory dir)))

(defun backup-files (from-dir name)
  (let ((to-dir (make-tmp-path name)))
    (fad:walk-directory
     from-dir (walker from-dir to-dir)
     :FOLLOW-SYMLINKS nil)
    (fad:walk-directory
     from-dir #'delete-empty
     :directories :depth-first
     :test
     (lambda (dir)
       (and (fad:directory-pathname-p dir)
            (not (uiop:pathname-equal dir from-dir))))
     :FOLLOW-SYMLINKS nil)))

(backup-files (home/ #p"Downloads/") "down")
(backup-files (home/ #p"tmp/") "tmp")
