(define-library (home packages icons)
  (import (scheme base)
          (gnu packages gnome)
          (gnu packages kde-frameworks)
          (gnu packages package-management))
  (export %icon-packages)
  (begin
    (define %icon-packages
      (list
       adwaita-icon-theme
       breeze-icons
       guix-icons
       hicolor-icon-theme
       oxygen-icons))))
