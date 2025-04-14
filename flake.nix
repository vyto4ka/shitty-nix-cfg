{
  description = "NixOS 24.11 config with Home Manager for multiple machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/nixos-24.11";
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations = {
      "vyt" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/vyt/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      "vytto4ka@vyt" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./hosts/vyt/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };

  }
}
