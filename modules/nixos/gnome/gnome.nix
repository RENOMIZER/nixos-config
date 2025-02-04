{ config, lib, pkgs, ... }:

let cfg = config.gnome; in {
  options = {
    gnome.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = (with pkgs; [
      geary
      gnome-maps
      gnome-connections
      gnome-contacts
      gnome-text-editor
      gnome-tour
      gnome-weather
      totem
      epiphany
    ]);
  };
}