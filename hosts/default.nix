{ inputs, self, ... }: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    sharedModules = import ../modules;
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };

    specialArgs = { inherit inputs pkgs-stable self; };
  in {
    tobenaitori = nixosSystem {
      inherit specialArgs;
      modules = [
        sharedModules
        inputs.home-manager.nixosModules.home-manager
        ./tobenaitori/configuration.nix
      ];
    };
    fbk = nixosSystem {
      inherit specialArgs;
      modules = [ 
        sharedModules
        inputs.home-manager.nixosModules.home-manager  
        ./fbk/configuration.nix 
      ];
    };
  };
}
