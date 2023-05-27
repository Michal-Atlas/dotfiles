self: super: {
  atlas-emacs =
    (super.emacsWithPackagesFromUsePackage {
      defaultInitFile = true;
      alwaysEnsure = true;
      config = ../home/files/emacs.el;
      package = super.emacsPgtk;
      extraEmacsPackages =
        epkg: [ epkg.auctex ];
    });
}
