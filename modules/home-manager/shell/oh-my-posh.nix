{ config, lib, ... }:

let cfg = config.oh-my-posh; in {
  options = {
    oh-my-posh.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "star";
    };
  };
}