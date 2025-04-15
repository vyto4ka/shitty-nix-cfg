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

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [ git ];
  };

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
  owner = "LazyVim";
  repo = "starter";
  rev = "2ae1cd4f45007fbbf3eb581c1f149f31e3bb0aa0";
  sha256 = "0000000000000000000000000000000000000000000000000000";
};
}
