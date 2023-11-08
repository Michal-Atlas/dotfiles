(+s home-files unison
    (let ((roots '("/home/michal_atlas"
                   "ssh://dagon.local//home/michal_atlas"))
          (paths '("Sync"
                   "Documents"
                   "cl"
                   "Zotero"
                   "Pictures"
                   "Music")))
      (define ((pref p) s)
        (string-append p "=" s "\n"))

      `((".unison/default.prf"
         ,(apply mixed-text-file "default.prf"
                 "auto=true\n"
                 "log=true\n"
                 "sortbysize=true\n"
                 "servercmd=" unison "/bin/unison\n"
                 (append
                  (map (pref "root") roots)
                  (map (pref "path") paths)))))))
