{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;
      [
        _2gua.rainbow-brackets
        christian-kohler.path-intellisense
        colejcummins.llvm-syntax-highlighting
        eamodio.gitlens
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
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      ];
    userSettings = {
      git.autofetch = true;
      nix.enableLanguageServer = true;
      files.autoSave = "afterDelay";
    };
  };
}
