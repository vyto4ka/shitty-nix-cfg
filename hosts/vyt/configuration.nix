{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  networking.hostName = "vyt";
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "ru_RU.UTF-8";
  time.timeZone = "Europe/Moscow";

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.desktopManager.plasma6.enable = true;

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
