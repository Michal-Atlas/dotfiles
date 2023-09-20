(define-library (utils download)
  (import (scheme base)
          (guix store)
          (guix download)
          (guix base64))
  (export file-fetch)

  (begin

    (define (file-fetch url hash)
      "Fetches an arbitrary file
from a URL, which may be used
anywhere a derivation may be used,
such as a G-Exp or mixed-text-file input"
      (with-store store
                  (run-with-store store
                                  (url-fetch url 'sha256 (base64-decode hash)))))))
