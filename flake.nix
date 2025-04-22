{
  description = "NixOS 24.11 config with Home Manager for multiple machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations = {
      "vyt" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # Ваши модули
        modules = [ ./hosts/vyt/configuration.nix ];

        # Собираем pkgs с allowUnfree
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      "vyto4ka@vyt" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./hosts/vyt/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
