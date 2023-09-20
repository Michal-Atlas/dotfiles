(define-library (home packages fonts)
  (import (scheme base)
          (gnu packages fonts)
          (gnu packages fontutils)
          (gnu packages ghostscript))
  (export %font-packages)
  (begin
    (define %font-packages
      (list
       font-adobe-source-han-sans
       font-adobe-source-han-sans
       font-awesome
       font-dejavu
       font-fira-code
       font-ghostscript
       font-gnu-freefont
       font-jetbrains-mono
       font-sil-charis
       font-tamzen
       font-wqy-microhei
       font-wqy-zenhei
       font-wqy-zenhei
       fontconfig))))
