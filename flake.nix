{
  description = "Pengiie/Nathan's NixOS/Home Manager Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    homeManager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    nixpkgs, 
    homeManager,
    nixos-hardware,
    nixpkgs-unstable,
    neovim-nightly-overlay,
    ...
  }@inputs: let
    cutil = import ./utils { inherit inputs; lib = nixpkgs.lib; };
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    mkSystem = modules: nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
      specialArgs = { inherit inputs cutil system; };
      modules = modules;
    };

    mkUser = modules: homeManager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs cutil system; };
      modules = modules;
    };
  in {
    nixosConfigurations = {
      laptop = mkSystem [ ./hosts/laptop ];
      desktop = mkSystem [ ./hosts/desktop ];
      fadedrya = mkSystem [ ./hosts/fadedrya ];
    };

    homeConfigurations = {
      nathan-desktop = mkUser [ ./hosts/desktop/config.nix ./users/nathan.nix ]; 
      nathan-laptop = mkUser [ ./hosts/laptop/config.nix ./users/nathan.nix ];
      nathan-fadedrya = mkUser [ ./hosts/fadedrya/config.nix ./users/fadedrya ];
    };
  };
}
