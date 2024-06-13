{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./helix.nix
  ];
  programs = {
    fzf.enable = true;
    dircolors.enable = true;
    keychain.enable = true;
    navi.enable = true;
    direnv = {
      nix-direnv.enable = true;
      enable = true;
    };
    zoxide = {
      enable = true;
      options = ["--cmd" "cd"];
    };
    starship.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch];
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [exts.pass-otp]);
    };
    gpg.enable = true;
  };
  services = {
    gpg-agent = {
      enable = true;
    };
  };
}
