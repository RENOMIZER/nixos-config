{ config, lib, ... }:

let cfg = config.gdm; in {
  options = {
    gdm.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager.gdm.enable = true;

    programs.dconf = {
      enable = true;
      profiles.gdm.databases = [
        {
          lockAll = true; # prevents overriding
          settings = {
            "org/gnome/desktop/wm/keybindings" = {
              switch-input-source = ["<Shift>Alt_L" "XF86Keyboard"];
              switch-input-source-backward = ["<Alt>Shift_L" "XF86Keyboard"];
            };
            "org/gnome/desktop/interface".cursor-theme = "Posy_Cursor_Black";
            "org/gnome/desktop/interface".font-name = "Source Sans 3 11";
          };
        }
      ];
    };
  };
}