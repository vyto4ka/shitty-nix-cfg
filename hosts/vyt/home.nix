{ pkgs, lib, ... }:

{
  home.stateVersion = "24.11";
  home.username = "vyto4ka";
  home.homeDirectory = "/home/vyto4ka";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    nekoray
    kitty
    nordic
    git
    vscodium
    libgcc
    netbeans
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

  home.activation.installLazyVim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  PATH="${pkgs.git}/bin:$PATH"
  if [ ! -e "$HOME/.config/nvim/init.lua" ]; then
    echo "[+] Cloning LazyVim starter config..."
    git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  else
    echo "[i] LazyVim config already exists. Skipping clone."
  fi
  '';
}
