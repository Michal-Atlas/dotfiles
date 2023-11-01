(modify-services %desktop-services
                 (network-manager-service-type configuration =>
                                               (network-manager-configuration
                                                (inherit configuration)
                                                (vpn-plugins
                                                 (list network-manager-openvpn))))
                 (delete gdm-service-type)
                 (delete pulseaudio-service-type)
                 (guix-service-type configuration =>
                                    (guix-configuration
                                     (discover? #t)
                                     (substitute-urls
                                      (cons* "https://substitutes.nonguix.org"
                                             "https://guix.bordeaux.inria.fr"
                                             %default-substitute-urls))
                                     (authorized-keys
                                      (append (list
                                               (plain-file "non-guix.pub"
                                                           "(public-key (ecc (curve Ed25519) (q #926B78EBA9416220CA0AFA2EAEC8ED99FC9E9C03AF11CD08AE6F8192BCF68673#)))")
                                               (plain-file "hydra.pub"
                                                           "(public-key (ecc (curve Ed25519) (q #629C1EFAFAB6A1D70E0CBC221C3F164226EBF72E52401CACEA0444CACA89E0D2#)))")
                                               (plain-file "dagon.pub"
                                                           "(public-key (ecc (curve Ed25519) (q #F5E876A29802796DBA7BAD8B7C0FEE90BDD784A70CB2CC8A1365A47DA03AADBD#)))")
                                               (plain-file "past.pub"
                                                           "(public-key (ecc (curve Ed25519) (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))"))
                                              %default-authorized-guix-keys))
                                     (build-machines
                                      (if (string= (gethostname) "hydra")
                                          (list)
                                          (list
                                           #~(build-machine
                                              (name "hydra")
                                              (user "michal_atlas")
                                              (systems (list "x86_64-linux"))
                                              (private-key "/home/michal_atlas/.ssh/id_rsa")
                                              (host-key "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINAIrtjcu5p0bORlaVvkqGgeSxD+uUUp114CaXOBOgqQ"))))))))