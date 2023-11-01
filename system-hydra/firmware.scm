(use-modules (atlas utils services)
             (nongnu packages linux)
             (gnu services))

(+s firmware amd (list amdgpu-firmware))
