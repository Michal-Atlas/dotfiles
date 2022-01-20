(define-module (atlas system progtest)
  #:use-module (gnu)
  #:use-module (gnu packages))

(use-service-modules
 desktop
 networking
 ssh
 xorg)
(use-package-modules
 text-editors
 shells
 gnome
 vim
 nano
 llvm
 gnuzilla
 mc
 gdb
 debug
 admin
 image
 valgrind
 video
 ncurses
 xml
 databases
 gl
 compression
 sdl
 photo
 sqlite
 crypto
 tls
 linux)

(define-public %progtest-system
  (operating-system
    (host-name "Progtest")
    (kernel linux-libre)
    (locale "en_US.utf8")
    (timezone "Europe/Prague")
    (keyboard-layout
     (keyboard-layout "us,cz" ",qwerty" #:options '("grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr")))
    (users (cons* (user-account
		   (name "progtest")
		   (comment "Progtest")
		   (group "users")
		   (password (crypt "progtest" "$6a8$"))
		   (shell (file-append (specification->package "bash") "/bin/bash"))
		   (supplementary-groups
		    '("netdev" "audio" "video")))
		  %base-user-accounts))
    (packages
     (list joe gedit scintilla
	   vim nano icecat mc sudo
	   clang-toolchain gdb cgdb valgrind
	   libxml2
	   ncurses
	   libpng
	   libjpeg-turbo
	   libmediainfo
	   libpqxx
	   sqlite
	   exiv2
	   libexif
	   zlib
	   sdl2 sdl2-image sdl2-mixer sdl2-ttf
	   freeglut glu ;; libgl1-mesa-{dri,dev,glx} libegl1-mesa{,-drivers,} libglapi-mesa
	   openssl crypto++
	   mariadb))
    (services
     (cons*
      (set-xorg-configuration
       (xorg-configuration
	(keyboard-layout keyboard-layout)))
      (service xfce-desktop-service-type)      
      %desktop-services))
    (bootloader
     (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets `("/boot/efi"))))
    (file-systems (list %base-file-systems))
    (name-service-switch %mdns-host-lookup-nss)))

%progtest-system
