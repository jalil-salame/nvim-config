{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixneovim.url = "github:NixNeovim/NixNeovim";

    # # to ensure no duplication of inputs
    nixneovimplugins.url = "github:NixNeovim/NixNeovimPlugins";
    home-manager.url = "github:nix-community/home-manager";

    # # Don't duplicate inputs
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixneovim.inputs.nixpkgs.follows = "nixpkgs";
    nixneovim.inputs.home-manager.follows = "home-manager";
    nixneovim.inputs.nixneovimplugins.follows = "nixneovimplugins";
    nixneovimplugins.inputs.nixpkgs.follows = "nixpkgs";
    nixneovimplugins.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    nixneovim,
    ...
  }:
    {
      nixosModules = let
        nvim-config = import ./nixos;
      in {
        inherit nvim-config;
        nixneovim = nixneovim.nixosModules.default;
        default = {};
      };
      overlays.nvim-config = nixneovim.overlays.default;
      overlays.default = nixneovim.overlays.default;
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
