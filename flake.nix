{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # nixneovim.url = "github:NixNeovim/NixNeovim";
    nixneovim.url = "github:jalil-salame/NixNeovim/ocaml-lsp";

    # To ensure no duplication of inputs (you'll probably use home-manager)
    home-manager.url = "github:nix-community/home-manager";

    # Don't duplicate inputs
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixneovim.inputs.nixpkgs.follows = "nixpkgs";
    nixneovim.inputs.flake-utils.follows = "flake-utils";
    nixneovim.inputs.home-manager.follows = "home-manager";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    nixneovim,
    ...
  }:
    {
      nixosModules = let
        nvim-config = import ./config;
      in {
        inherit nvim-config;
        nixneovim = nixneovim.nixosModules.homeManager;
        nixneovim-23-05 = nixneovim.nixosModules.homeManager-23-05;
        default = {};
      };
      inherit (nixneovim) overlays;
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
