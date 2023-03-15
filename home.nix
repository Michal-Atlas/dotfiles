{ self, config, pkgs, home-manager, ... }:

{
  home.username = "michal_atlas";
  home.homeDirectory = "/home/michal_atlas";
  programs.git = {
    enable = true;
    userName = "Michal Atlas";
    userEmail = "michal_atlas+git@posteo.net";
  };
  # nixpkgs.overlays = [ (self: super: emacs-overlay) ];
  nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];
  home-manager.users.michal_atlas = {
    # The home.stateVersion option does not have a default and must be set
    home.stateVersion = "22.11";
    # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    home.sessionVariables = { EDITOR = "emacs"; };
    home.shellAliases.gx = "nix-env";
    programs.bash.initExtra = ''
      recon () { sudo sh -c 'nixos-rebuild switch -I nixos-config=$HOME/dotfiles/configuration.nix |& nom'; }
    '';
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };
    home.file.".emacs.d/init.el".source = ./emacs.el;

    home.file.".guile".source = ./guile;
    home.file.".mbsyncrc".source = ./mbsyncrc;
    home.file.".sbclrc".source = ./sbclrc;
    home.file.".config/common-lisp/source-registry.conf".source =
      ./cl-src-registry.conf;

    home.file.".config/sway/config".source = ./sway.cfg;
    xsession.numlock.enable = true;
    programs.home-manager.enable = true;
    home.packages = with pkgs;
      [

      ];
  };
}
