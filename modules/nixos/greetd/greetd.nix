{ config, lib, ... }:

let 
  cfg = config.greetd;
in {
  options = {
    greetd.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${config.programs.hyprland.package}/bin/Hyprland";
          user = "konstantin";
        };
        default_session = initial_session;
      };
    };
  };
}