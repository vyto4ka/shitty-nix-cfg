{
  description = "NixOS 24.11 + Home Manager";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # указываем, что home‑manager должен следовать за тем же nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      vyt = pkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/vyt/configuration.nix
        ];

        # передаём inputs внутрь configuration.nix
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      "vyto4ka@vyt" = home-manager.lib.homeManagerConfiguration {
        pkgs               = pkgs;
        modules            = [ ./hosts/vyt/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
