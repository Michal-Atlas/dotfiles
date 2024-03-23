{
  self,
  nur,
  emacs-overlay,
  atlas-overlay,
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
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "nix-2.15.3"
      ];
    };
  };
}
