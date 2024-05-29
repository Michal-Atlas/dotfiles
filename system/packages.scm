(define-module (system packages)
  #:use-module (atlas utils services)
  #:use-module (gnu services)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages file-systems)
  #:export (packages))

(define-public packages
  (+s profile certs (list nss-certs ntfs-3g
                          davfs2
                          netcat)))
