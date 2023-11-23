{
  description = "NixOS Configuration";

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
  }@args: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    user = "nathan";
    hostname = "nathan-laptop";
    specialArgs = args;
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      modules = [ 
        nixos-hardware.nixosModules.microsoft-surface-common
	./system 
      ];
    };

    homeConfigurations.${user} = homeManager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = specialArgs;
      modules = [
        ./home
      ];
    };
  };
}
