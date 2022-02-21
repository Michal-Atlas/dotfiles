(append (list (channel
	       (name 'nonguix)
	       (url "https://gitlab.com/nonguix/nonguix")
	       (branch "master"))
	      (channel
	       (name 'game)
	       (url "https://gitlab.com/guix-gaming-channels/games")
	       (branch "master"))
	      (channel
	       (name 'guixrus)
	       (url "https://git.sr.ht/~whereiseveryone/guixrus")
	       (introduction
		(make-channel-introduction
		 "7c67c3a9f299517bfc4ce8235628657898dd26b2"
		 (openpgp-fingerprint
		  "CD2D 5EAA A98C CB37 DA91  D6B0 5F58 1664 7F8B E551")))))
	      (channel
	       (name 'atlas)
	       (url "https://git.sr.ht/~michal_atlas/guix-channel")))
	%default-channels)
