{
  emacs-overlay,
  unison-nix,
  ...
}: {
  nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };
  nixpkgs = {
    overlays = [
      emacs-overlay.overlays.default
      unison-nix.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
}
