{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvim-config.url = "github:jalil-salame/nvim-config";
    nvim-config.inputs.nixpkgs.follows = "nixpkgs";
    nvim-config.inputs.home-manager.follows = "home-manager";
    # nvim-config.inputs.flake-utils.follows = "flake-utils"; # If you have flake-utils as an input
  };
  outputs =
    { self
    , nixpkgs
    , home-manager
    , nvim-config
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nvim-config.overlays.default ];
      };
      nvim-modules = { inherit (nvim-config.nixosModules) nvim-config nixneovim; };
      hostname = "my-pc";
    in
    {
      nixosConfigurations.${hostname} = {
        inherit system pkgs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.name = ./home.nix;
            home-manager.extraSpecialArgs = { inherit nvim-modules; };
          }
        ];
      };
    };
}
