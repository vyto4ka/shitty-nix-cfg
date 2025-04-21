# /etc/nixos/flake.nix
{
  description = "NixOS 24.11 + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    # Импортируем nixpkgs, сразу отключая labwc-модуль
    pkgs = import nixpkgs {
      inherit system;
      config = {
        disabledModules = [ "services/window-managers/labwc.nix" ];
      };
    };
  in {
    # NixOS-конфигурация
    nixosConfigurations = {
      vyt = pkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/vyt/configuration.nix
        ];

        # чтобы внутри configuration.nix был доступ к inputs
        specialArgs = { inherit inputs; };
      };
    };

    # Home Manager
    homeConfigurations = {
      "vyto4ka@vyt" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/vyt/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
