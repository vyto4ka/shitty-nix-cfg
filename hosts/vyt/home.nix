{ pkgs, ... }:

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


  home.file.".config/kitty/kitty.conf" = {
    text = ''
      font_family FiraCode Nerd Font Mono 12
      confirm_os_window_close 0
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
