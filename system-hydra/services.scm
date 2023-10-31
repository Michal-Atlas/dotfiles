(list
 (&s hurd-vm)
 (&s cuirass
     (interval (* 24 60 60))
     (host "0.0.0.0")
     (use-substitutes? #t)
     (specifications
      #~(list (specification
               (name "atlas")
               (build '(channels atlas))
               (channels
                (cons
                 (channel
                  (name 'atlas)
                  (url "https://git.sr.ht/~michal_atlas/guix-channel")
                  (introduction
                   (make-channel-introduction
                    "f0e838427c2d9c495202f1ad36cfcae86e3ed6af"
                    (openpgp-fingerprint
                     "D45185A2755DAF831F1C3DC63EFBF2BBBB29B99E"))))
                 %default-channels))))))
 (&s quassel)
 (&s tes3mp-server))
