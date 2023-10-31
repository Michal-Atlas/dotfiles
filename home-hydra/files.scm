(+s home-files unison
    `((".unison/default.prf"
       ,(local-file "../../../files/default.prf"))
      (".unison/watch.prf"
       ,(plain-file "default.prf"
                    "include default
repeat=watch"))))
