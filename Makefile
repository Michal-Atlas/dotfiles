install-pkgs:
	<packages xargs sudo zypper --non-interactive in

install-patterns:
	<patterns xargs sudo zypper --non-interactive in -t pattern

bootstrap-spotify:
	which spotify || spotify-easyrpm

bootstrap-proton:
	which proton-mail || sudo zypper in 'https://proton.me/download/mail/linux/1.2.4/ProtonMail-desktop-beta.rpm'

bootstrap-yggdrasil:
	which yggdrasilctl || sudo zypper ar 'https://copr.fedorainfracloud.org/coprs/neilalexander/yggdrasil-go/repo/opensuse-tumbleweed/neilalexander-yggdrasil-go-opensuse-tumbleweed.repo' && sudo zypper in yggdrasil

stow-home:
	stow --target=${HOME} --dotfiles home

dconf:
	dconf load / < d.conf

doom:
	git clone --depth 1 'https://github.com/doomemacs/doomemacs' ~/.config/emacs
	~/.config/emacs/bin/doom install

quicklisp:
	wget -nc 'https://beta.quicklisp.org/quicklisp.lisp' -O ~/cl/quicklisp.lisp
	sbcl --load ~/cl/quicklisp.lisp