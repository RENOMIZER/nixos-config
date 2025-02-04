{ lib, config, ... }:

let cfg = config.gnome; in {
  options = {
    gnome.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/wm/keybindings" = {
          switch-input-source = ["<Shift>Alt_L" "XF86Keyboard"];
          switch-input-source-backward = ["<Alt>Shift_L" "XF86Keyboard"];
        };
      };
    };
  };
}