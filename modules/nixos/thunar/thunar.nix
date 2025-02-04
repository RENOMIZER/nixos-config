{ pkgs, config, lib, ... }:

let cfg = config.thunar; in {
  options = {
    thunar.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    programs.xfconf.enable = true;
    programs.file-roller.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [  
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
  };
}