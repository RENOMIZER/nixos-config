{ lib, config, ... }:

let cfg = config.hyprlock; in {
  options = {
    hyprlock.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          no_fade_in = false;
        };

        animations = {
          enabled = true;
          bezier = "linear, 1, 1, 0, 0";
          animation = [
            "fadeIn, 1, 5, linear"
            "fadeOut, 1, 5, linear"
          ];
        };

        label = [
          {
            font_size = "72";
            font_family = "Source Sans 3";
            position = "0, 300";
            monitor = "";
            text = "<span foreground='##fbf1c7'><b>$TIME</b></span>";
            halign = "center";
            valign = "center";
          }
          {
            font_size = "20";
            font_family = "Source Sans 3";
            position = "0, 215";
            monitor = "";
            text = "cmd[update:1000] echo \"<span foreground='##fbf1c7'>$(date +\'%A, %d %B\')</span>\"";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = [
          {
            size = "400, 50";
            position = "0, 0";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_family = "Source Sans 3";
            font_color = "rgb(251, 241, 199)";
            inner_color = "rgb(60, 56, 54)";
            outer_color = "rgb(29, 32, 33) rgb(40, 40, 40) 45deg";
            check_color = "rgba(8ec07cee) rgba(689d6aee) 45deg";
            fail_color = "rgba(cc241dee) rgba(fb4934ee) 45deg";
            capslock_color = "rgba(458588ee) rgba(83a598ee) 45deg";
            fail_timeout = 1000;
            fail_text = "<b>Неверный пароль</b>";
            rounding = 10;
            outline_thickness = 5;
            placeholder_text = "Пароль...";
            shadow_passes = 2;
          }
        ];

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
      };
    };
  };
}