self: super: {
  atlas-emacs =
    super.emacsWithPackagesFromUsePackage {
      defaultInitFile = true;
      alwaysEnsure = true;
      config = ../home/files/emacs.el;
      package = super.emacs-pgtk;
      extraEmacsPackages =
        epkg: [ epkg.auctex ];
    };
}
