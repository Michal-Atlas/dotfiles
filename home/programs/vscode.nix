{pkgs, ...}: {
  programs.vscode = {
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
}
