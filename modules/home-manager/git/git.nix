{ lib, config, ... }:

let cfg = config.git; in {
  options = {
    git.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    programs.git = { 
      enable = true;
      userEmail = "94466218+RENOMIZER@users.noreply.github.com";
      userName  = "RENOMIZER";
    };
  };
}