_: super: {
  atlas-emacs = super.emacsWithPackagesFromUsePackage {
    defaultInitFile = true;
    alwaysEnsure = true;
    config = ../files/emacs.el;
    package = super.emacs29-pgtk;
    extraEmacsPackages = _: [];
  };
}
