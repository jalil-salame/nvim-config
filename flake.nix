{
  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

  inputs.nixneovim.url = "github:NixNeovim/NixNeovim";
  inputs.nixneovim.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixneovim.inputs.home-manager.follows = "home-manager";

  inputs.home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.*.tar.gz";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

  inputs.flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*.tar.gz";

  outputs = { nixpkgs, flake-schemas, nixneovim, neovim-nightly, ... }:
    let
      # Helpers for producing system-specific outputs
      inherit (nixpkgs) lib;
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
      forEachSupportedSystem = f: lib.genAttrs supportedSystems (system: f (import nixpkgs { inherit system; }));
      # Create module
      nvim-config.imports = [
        nixneovim.nixosModules.homeManager
        ./config
      ];
    in
    {
      # Schemas tell Nix about the structure of your flake's outputs
      inherit (flake-schemas) schemas;

      overlays.nixneovim = nixneovim.overlays.default;
      overlays.neovim-nightly = neovim-nightly.overlays.default;

      nixosModules = {
        inherit nvim-config;
        default = nvim-config;
      };

      formatter = forEachSupportedSystem (pkgs: pkgs.nixpkgs-fmt);
    };
}
