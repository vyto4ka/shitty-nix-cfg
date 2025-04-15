{ pkgs, lib, ... }:

{
  home.stateVersion = "25.05";
  home.username = "vyto4ka";
  home.homeDirectory = "/home/vyto4ka";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    nekoray
    kitty
    nordic
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  home.file.".config/kitty/kitty.conf".source = ./kitty/kitty.conf;
  home.file.".config/kitty/current-theme.conf".source = ./kitty/current-theme.conf;

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [ git ];
  };

  home.file.".local/share/nvim/site/pack/lazy/start/lazy.nvim".source = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "lazy.nvim";
    rev = "main";
    sha256 = "0000000000000000000000000000000000000000000000000000" ;
  };
}
