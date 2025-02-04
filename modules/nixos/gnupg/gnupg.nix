{ lib, config, ... }:

let cfg = config.gnupg; in {
  options = {
    gnupg.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}