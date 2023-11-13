(define-module (home hydra spotifyd)
  #:use-module (atlas utils services)
  #:use-module (gnu home services shepherd)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:use-module (guix gexp)
  #:export (hydra:spotifyd))

(define (inferior)
  (inferior-for-channels
   (list (channel
          (name 'guix)
          (url "https://git.savannah.gnu.org/git/guix.git")
          (branch "rust-team")
          (commit
           "bbec79fd55ba8efe4cb015bd07e4f40fb7d252d1")
          (introduction
           (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))))

(define (hydra:spotifyd)
  (+s home-shepherd spotifyd
      (list
       (shepherd-service
        (provision '(spotifyd))
        (start
         #~(make-forkexec-constructor
            (list
             #$(file-append
                (car (lookup-inferior-packages
                      (inferior)
                      "spotifyd"))
                "/bin/spotifyd")
             "--no-daemon")))
        (stop #~(make-kill-destructor))))))
