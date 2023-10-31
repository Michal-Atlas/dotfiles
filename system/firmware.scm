(use-modules (atlas utils services)
             (gnu services)
             (nongnu packages linux))

(+s firmware linux (list linux-firmware))
