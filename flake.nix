{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # nixneovim.url = "github:jalil-salame/NixNeovim/autocmds";
    # Latest commit is broken: https://github.com/NixNeovim/NixNeovim/pull/66#issuecomment-1619026859
    nixneovim.url = "github:jalil-salame/NixNeovim/8b9d837057f690320d742389204515bc557aeb1f";

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
