install-pkgs:
	<packages xargs sudo zypper --non-interactive in

stow-home:
	stow --target=${HOME} --dotfiles home
