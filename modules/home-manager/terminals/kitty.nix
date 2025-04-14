# Модуль для настройки Kitty через Home Manager
{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      font_family FiraCode Nerd Font Mono 12
      cursor_shape Beam
    '';
  };
}
