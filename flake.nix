{
  description = "Pengiie/Nathan's NixOS/Home Manager Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs, 
    homeManager,
    nixos-hardware,
    ...
  }@inputs: let
    cutil = import ./utils { inherit inputs; lib = nixpkgs.lib; };
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system; 
      config = {
        allowUnfree = true;
        allowUnfreePredicate =  _: true;
      };
    };

    mkSystem = modules: nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      specialArgs = { inherit inputs cutil; };
      modules = modules;
    };

    mkUser = modules: homeManager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs cutil; };
      modules = modules;
    };
  in {
    nixosConfigurations = {
      laptop = mkSystem [ ./hosts/laptop ];
      desktop = mkSystem [ ./hosts/desktop ];
    };

    homeConfigurations = {
      nathan-desktop = mkUser [ ./hosts/desktop/config.nix ./users/nathan ]; 
      nathan-laptop = mkUser [ ./hosts/laptop/config.nix ./users/nathan ];
    };
  };
}
