(use-modules (atlas utils services))

(+s account atlas
    (list
     (user-account
      (name "michal_atlas")
      (comment "Michal Atlas")
      (group "users")
      (home-directory "/home/michal_atlas")
      (supplementary-groups
       '("wheel" "netdev" "audio"
         "video" "libvirt" "kvm" "tty" "transmission")))))
