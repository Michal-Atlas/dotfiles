(define-library (system filesystems swap)
  (import (scheme base)
          (atlas utils services)
          (system filesystems mapped)
          (gnu system file-systems))
  (export %swap)
  (begin
    (define %swap
      (@host
       #:dagon (swap-space
	        (target "/dev/mapper/rpool-swap")
	        (dependencies %mapped-devices))
       #:hydra (swap-space
	        (target (file-system-label "SWAP")))))))
