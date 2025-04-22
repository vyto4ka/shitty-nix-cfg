{
  description = "…";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = outputs = inputs@{ self, nixpkgs, home-manager, … }: let
    system = "x86_64-linux";
    pkgsUnfree = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
  in {
    nixosConfigurations = {
      "vyt" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/vyt/configuration.nix ];
        pkgs = pkgsUnfree;
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      "vyto4ka@vyt" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./hosts/vyt/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
