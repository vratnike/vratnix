{ inputs, self, ... }: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    #sharedModules = import ../modules; no longer have anything in modules folder, fix later after I learn more
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };

    specialArgs = { inherit inputs pkgs-stable self; };
  in {
    shamare = nixosSystem {
      inherit specialArgs;
      modules = [
        #sharedModules
        inputs.home-manager.nixosModules.home-manager
        ../overlays/linux-firmware_20240610.nix
        #../overlays/hydrus-614.nix
        ./shamare/configuration.nix
      ];
    };
    fbk = nixosSystem {
      inherit specialArgs;
      modules = [ 
        #sharedModules
        inputs.home-manager.nixosModules.home-manager  
        ./fbk/configuration.nix 
      ];
    };
    suzuran = nixosSystem {
      inherit specialArgs;
      modules = [ 
        #sharedModules
        #../overlays/hydrus-614.nix
        inputs.home-manager.nixosModules.home-manager  
        ./suzuran/configuration.nix
      ];
    };
  };
}
