{ pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable modules
  gdm.enable    = false;
  gnome.enable  = false;
  greetd.enable = true;
  nvidia.enable = true;
  polkit.enable = true;
  zapret.enable = true;
  thunar.enable = true;
  gnupg.enable  = true;
  tor.enable    = true;

  # Enable programs
  programs.zsh.enable       = true;
  programs.adb.enable       = true;
  programs.hyprland.enable  = true;
  programs.localsend.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # environment.systemPackages = with pkgs; [  ];

  # Environment variables
  environment.pathsToLink = [ "/share/zsh" ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.konstantin = {
    isNormalUser = true;
    description  = "Konstantin";
    extraGroups  = [ "networkmanager" "wheel" ];
    shell        = pkgs.zsh;
  };

  # Setup home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "konstantin" = import ./home.nix;
    };
  };

  # Bootloader
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "RENOMIZER";

  # Language/region settings
  time.timeZone      = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT    = "ru_RU.UTF-8";
    LC_MONETARY       = "ru_RU.UTF-8";
    LC_NAME           = "ru_RU.UTF-8";
    LC_NUMERIC        = "ru_RU.UTF-8";
    LC_PAPER          = "ru_RU.UTF-8";
    LC_TELEPHONE      = "ru_RU.UTF-8";
    LC_TIME           = "ru_RU.UTF-8";
  };

  # Xserver settings
  services.xserver = {
    enable = true;
    xkb = {
      options = "grp:alt_shift_toggle";
      layout  = "us,ru";
    };
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable      = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  services.logind.extraConfig = ''
    HandlePowerKey=suspend-then-hibernate
    HandlePowerKeyLongPress=poweroff
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchExternalPower=suspend-then-hibernate
    HandleLidSwitchDocked=suspend-then-hibernate
    HoldoffTimeoutSec=5s
  '';

  powerManagement.enable = true;

  systemd.sleep.extraConfig = "HibernateDelaySec=20min";

  services.upower = {
    enable                 = true;
    usePercentageForPolicy = true;
    criticalPowerAction    = "Hibernate";
    percentageAction       = 5;
    percentageCritical     = 10;
    percentageLow          = 20;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
