{
  self,
  nur,
  emacs-overlay,
  atlas-overlay,
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
    overlays = with self.inputs; [
      nur.overlay
      emacs-overlay.overlays.default
      (import ../overlays/atlas-emacs.nix)
      atlas-overlay.overlays.x86_64-linux.default
      unison-nix.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
}
