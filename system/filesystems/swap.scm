(define-library (system filesystems swap)
  (import (scheme base)
          (scheme lazy)
          (utils services)
          (system filesystems mapped)
          (gnu system file-systems))
  (export %swap)
  (begin
    (define %swap
      (delay
       (@host
        #:dagon (swap-space
	         (target "/dev/mapper/rpool-swap")
	         (dependencies %mapped-devices))
        #:hydra (swap-space
	         (target (file-system-label "SWAP"))))))))
