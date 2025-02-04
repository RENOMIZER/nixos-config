{ pkgs, inputs, lib, config, ... }:

let cfg = config.astal; in {
  imports = [ inputs.ags.homeManagerModules.default ];
  
  options = {
    astal.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;
      configDir = ./astal;
      extraPackages = [
        inputs.ags.packages.${pkgs.system}.apps
        inputs.ags.packages.${pkgs.system}.hyprland
        inputs.ags.packages.${pkgs.system}.mpris
        inputs.ags.packages.${pkgs.system}.battery
        inputs.ags.packages.${pkgs.system}.wireplumber
        inputs.ags.packages.${pkgs.system}.network
        inputs.ags.packages.${pkgs.system}.tray
        inputs.ags.packages.${pkgs.system}.notifd
      ];
    };
  };
}