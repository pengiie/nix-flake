{
  description = "Pengiie/Nathan's NixOS/Home Manager Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-24.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    homeManager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";

      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    firefox-nightly.url = "github:mozilla/nixpkgs-mozilla";

    fenix = {
      url = "github:nix-community/fenix";
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
          permittedInsecurePackages = [
            "dotnet-runtime-6.0.36"
            "dotnet-sdk-wrapped-6.0.428"
            "dotnet-sdk-6.0.428"
          ];
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
      nathan-laptop = mkUser [ ./hosts/laptop/config.nix ./users/nathan-laptop.nix ];
      nathan-fadedrya = mkUser [ ./hosts/fadedrya/config.nix ./users/fadedrya ];
    };
  };
}
