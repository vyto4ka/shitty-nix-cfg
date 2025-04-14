{ pkgs, ... }:

{
  home.username = "vyto4ka";
  home.homeDirectory = "/home/vyto4ka";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    nekoray
    kitty
    neovim
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };

  home.file.".config/kitty/kitty.conf" = {
    text = ''
      font_family FiraCode Nerd Font Mono 12
      cursor_shape Beam
    '';
  };

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
  };
}
