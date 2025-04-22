{ config, pkgs, inputs, ... }:

{

  system.stateVersion = "24.11";
  imports = 
  [ 
    ../../hardware-configuration.nix
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

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.xkb = {
    layout = "us,ru";
    variant = ",";
    options = "grp:alt_shift_toggle";
  };
  
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
   nerd-fonts.fira-code
   nerd-fonts.droid-sans-mono
   nerd-fonts._0xproto
 ];
 
  programs.zsh.enable = true;
  
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "vyto4ka" ];

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
