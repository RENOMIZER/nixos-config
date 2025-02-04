{ lib, config, ... }:

let cfg = config.hyprland-cursor; in {
  options = {
    hyprland-cursor.enable = lib.mkEnableOption "Enable module";
    hyprland-cursor.name = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "Adwaita";
      description = "Set cursor theme";
    };
    hyprland-cursor.size = lib.mkOption {
      type = lib.types.str;
      default = "24";
      example = "24";
      description = "Set cursor size";
    };
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      cursorTheme = {
        name = "${cfg.name}";
        size = lib.toInt cfg.size;
      };
    };

    wayland.windowManager.hyprland.settings = {
      env = [
        "XCURSOR_SIZE,${cfg.size}"
        "XCURSOR_THEME,${cfg.name}"
        "HYPRCURSOR_SIZE,${cfg.size}"
        "HYPRCURSOR_THEME,${cfg.name}"
      ];
    };
  };
}