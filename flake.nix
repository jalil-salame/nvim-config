{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  # inputs.nixneovim.url = "github:jalil-salame/NixNeovim/remove-events-enum";
  inputs.nixneovim.url = "github:NixNeovim/NixNeovim";
  inputs.nixneovim.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixneovim.inputs.flake-utils.follows = "flake-utils";
  inputs.nixneovim.inputs.home-manager.follows = "home-manager";

  inputs.nixneovimplugins.url = "github:jalil-salame/NixNeovimPlugins/idris2-plugin";
  inputs.nixneovimplugins.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixneovimplugins.inputs.flake-utils.follows = "flake-utils";
  inputs.nixneovim.inputs.nixneovimplugins.follows = "nixneovimplugins";

  inputs.neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

  # To ensure no duplication of inputs (you'll probably use home-manager)
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    nixpkgs,
    flake-utils,
    nixneovim,
    neovim-nightly,
    ...
  }: let
    nvim-config = import ./config;
    overlays = {
      nixneovim = nixneovim.overlays.default;
      neovim-nightly = neovim-nightly.overlay;
    };
  in
    {
      nixosModules = {
        inherit nvim-config;
        nixneovim = nixneovim.nixosModules.homeManager;
        nixneovim-23-05 = nixneovim.nixosModules.homeManager-23-05;
        default = {};
      };
      inherit overlays;
    }
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        formatter = pkgs.alejandra;
      }
    );
}
