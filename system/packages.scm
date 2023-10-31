(use-modules (atlas utils services)
             (gnu packages certs)
             (gnu packages linux))

(+s profile certs (list nss-certs ntfs-3g))
