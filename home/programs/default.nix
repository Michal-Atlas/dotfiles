{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./git.nix
    ./ssh.nix
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
    nix-index.enable = true;
    password-store.enable = true;
    gpg.enable = true;
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        _2gua.rainbow-brackets
        christian-kohler.path-intellisense
        colejcummins.llvm-syntax-highlighting
        eamodio.gitlens
        enkia.tokyo-night
        github.copilot
        haskell.haskell
        james-yu.latex-workshop
        jnoortheen.nix-ide
        kahole.magit
        kamadorueda.alejandra
        llvm-org.lldb-vscode
        mads-hartmann.bash-ide-vscode
        mattn.lisp
        mkhl.direnv
        ms-vscode.cpptools
        ms-vscode.hexeditor
        ms-vscode.makefile-tools
        yzhang.markdown-all-in-one
      ];
    };
  };
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };
}
