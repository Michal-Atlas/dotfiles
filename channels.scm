(define-module (channels)
  #:use-module (guix channels)
  #:export (%channels))

(define %channels
 (list
  (channel
   (name 'nonguix)
   (url "https://gitlab.com/nonguix/nonguix")
   (branch "master")
   (introduction
    (make-channel-introduction
     "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
     (openpgp-fingerprint
      "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
  (channel
   (name 'guixrus)
   (url "https://git.sr.ht/~whereiseveryone/guixrus")
   (introduction
    (make-channel-introduction
     "7c67c3a9f299517bfc4ce8235628657898dd26b2"
     (openpgp-fingerprint
      "CD2D 5EAA A98C CB37 DA91  D6B0 5F58 1664 7F8B E551"))))
  (channel
   (name 'atlas)
   (url "https://git.sr.ht/~michal_atlas/guix-channel")
   (introduction
    (make-channel-introduction
     "f0e838427c2d9c495202f1ad36cfcae86e3ed6af"
     (openpgp-fingerprint
      "D45185A2755DAF831F1C3DC63EFBF2BBBB29B99E"))))
  (channel
   (name 'guix-gaming-games)
   (url "https://gitlab.com/guix-gaming-channels/games.git")
   (introduction
    (make-channel-introduction
     "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
     (openpgp-fingerprint
      "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))
  (channel
   (name 'rde)
   (url "https://git.sr.ht/~abcdw/rde")
   (introduction
    (make-channel-introduction
     "257cebd587b66e4d865b3537a9a88cccd7107c95"
     (openpgp-fingerprint
      "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
  (channel
   (name 'unwox)
   (url "https://git.sr.ht/~unwox/guix-pkgs")
   (introduction
    (make-channel-introduction
     "9e7a681dece5688c792755bf047f664fb859b47a"
     (openpgp-fingerprint
      "43E6 223B 3497 270A 6162  82FF B675 80AB 5694 9C84"))))
  (channel
   (name 'engstrand-wallpapers)
   (url "https://github.com/engstrand-config/wallpapers")
   (branch "main")
   (introduction
    (make-channel-introduction
     "ef88c361750170ec80a0276767328961a5547533"
     (openpgp-fingerprint
      "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))
  %default-guix-channel))
