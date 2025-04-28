outputs = inputs@{ … }: let
  system      = "x86_64-linux";
  nixpkgs      = inputs.nixpkgs;
  disko        = inputs.disko;
  homeManager  = inputs."home-manager";

  # Ваши unfree-пакеты
  pkgsUnfree = import nixpkgs {
    inherit system;
    config = { allowUnfree = true; };
  };
in {
  nixosConfigurations = {
    vyt = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        disko.nixosModules.disko
        ./hosts/vyt/disko-config.nix
        ./hosts/vyt/configuration.nix
      ];
      pkgs        = pkgsUnfree;
      specialArgs = { inherit inputs; };
    };
  };

  homeConfigurations = {
    "vyto4ka@vyt" = homeManager.lib.homeManagerConfiguration {
      pkgs             = nixpkgs.legacyPackages.${system};
      modules          = [ ./hosts/vyt/home.nix ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
