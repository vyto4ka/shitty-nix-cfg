{
  description = "…";

  inputs = {
    nixpkgs.url         = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url    = "github:nix-community/home-manager";
    disko.url           = "github:nix-community/disko";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.inputs.nixpkgs.follows        = "nixpkgs";
  };

outputs = inputs@{ … }: let
  system      = "x86_64-linux";
  nixpkgs      = inputs.nixpkgs;
  disko        = inputs.disko;
  # Вместо деструктуризации с дефисом — просто берём из inputs
  homeManager  = inputs."home-manager";

  # Ваши unfree-пакеты
  pkgsUnfree = import nixpkgs {
    inherit system;
    config = { allowUnfree = true; };
  };
in {
  # NixOS-конфигурация
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

  # Home-Manager-конфигурация
  homeConfigurations = {
    "vyto4ka@vyt" = homeManager.lib.homeManagerConfiguration {
      pkgs             = nixpkgs.legacyPackages.${system};
      modules          = [ ./hosts/vyt/home.nix ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
};
}
