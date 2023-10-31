(use-modules (atlas utils services)
             (gnu services pm))

(&s tlp
    (cpu-boost-on-ac? #t)
    (wifi-pwr-on-bat? #t))
