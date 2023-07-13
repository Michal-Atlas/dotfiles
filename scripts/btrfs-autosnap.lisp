(require 'asdf)
(require 'clingon)
(require 'local-time)

(defconstant +cmd-options+
  (list
   (clingon:make-option
    :string
    :description "Label to use on the backup"
    :key :label
    :required t
    :long-name "label"
    :short-name #\l)
   (clingon:make-option
    :filepath
    :description "Path to filesystem to perform backup on"
    :key :path
    :required t
    :long-name "path"
    :short-name #\p)
   (clingon:make-option
    :integer
    :required t
    :description "Number of instances to keep"
    :key :retention
    :long-name "retention"
    :short-name #\r)))

(defvar *path*)
(defvar *snapdir*)
(defvar *label*)
(defvar *retention*)

(defun snappath (id)
  (merge-pathnames
   (write-to-string id)
   *snapdir*))

(defun remove-snapshot (label)
  (uiop:run-program
   (list "btrfs" "su" "de"
         (namestring (snappath label)))))

(defun create-snapshot (label)
  (uiop:run-program
   (list "btrfs" "su" "snap" "-r"
         (namestring *path*)
         (namestring (snappath label)))))

(defun get-old-snaps ()
  (let ((l (sort
            (delete-if-not
             (lambda (q)
               (string= *label* (cdr (assoc :label q :test #'string=))))
             (mapcar
              (lambda (pn)
                (uiop:safe-read-from-string
                 (namestring (uiop:enough-pathname
                              pn
                              *snapdir*))))
              (uiop:directory*
               (merge-pathnames
                #p "*.*"
                *snapdir*))))
            (lambda (x y)
              (string>
               (cdr (assoc :date x :test #'string=))
               (cdr (assoc :date y :test #'string=)))))))
   (subseq l (min (length l) *retention*))))

(defun remove-old-snaps ()
  (dolist (sn (get-old-snaps))
    (remove-snapshot sn)))

(defun main (cmd)
  (let ((*path* (clingon:getopt cmd :path))
        (*snapdir*
         (merge-pathnames
          #p".btrfs/"
          (clingon:getopt cmd :path)))
        (*label*
          (clingon:getopt cmd :label))
        (*retention*
          (clingon:getopt cmd :retention)))
    (create-snapshot
     `((:label . ,*label*)
       (:date . ,(local-time:format-timestring
                 nil (local-time:now)))))
    (remove-old-snaps)))

(clingon:run
 (clingon:make-command
  :name "btrfs-autosnap"
  :version "0.1.0"
  :options +cmd-options+
  :handler #'main))
