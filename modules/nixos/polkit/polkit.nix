{ config, lib, ... }:

let cfg = config.polkit; in {
  options = {
    polkit.enable = lib.mkEnableOption "Enable module";
  };

  config = lib.mkIf cfg.enable {
    # Enable polkit and allow reboot and shutdown for unprivileged users.
    security.polkit.enable = true;
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      });
    '';
  };
}