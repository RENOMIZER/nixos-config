{ config, lib, ... }:

let cfg = config.kitty; in {
  options = {
    kitty.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        tab_bar_edge = "top";
        tab_bar_style = "separator";
        tab_separator = " ┇";
        tab_title_template = "{index}: {title} {activity_symbol}";
        window_padding_width = 5;
      };
      keybindings = {
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
      };
      font.size = 16.0;
      font.name = "JetBrainsMono Nerd Font Mono";
      themeFile = "Monokai_Soda";
    };
  };
}
