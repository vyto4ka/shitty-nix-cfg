{ config, pkgs, inputs, ... }:

{
  nixpkgs.config = {
    disabledModules = [
      "modules/services/window-managers/labwc.nix"
    ];
  };


  imports = 
  [ 
    ./hardware-configuration.nix
    (import "${inputs.home-manager}/nixos")
  ];

  home-manager.users.vyto4ka = import ./home.nix;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  networking.hostName = "vyt";
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "ru_RU.UTF-8";
  time.timeZone = "Europe/Moscow";

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma";

  services.desktopManager.plasma6.enable = true;

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
 
  programs.zsh.enable = true;

  users.users.vyto4ka = {
    isNormalUser = true;
    description = "Main user";
    home = "/home/vyto4ka";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    git
  ];
}
