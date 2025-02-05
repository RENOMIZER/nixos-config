{ pkgs, inputs, ... }:

{
  imports = [
    inputs.self.outputs.modules.home-manager.default
  ];

  # Enable modules;
  gnome.enable      = false;
  oh-my-posh.enable = true;
  hyprland.enable   = true;
  kitty.enable      = true;
  zsh.enable        = true;
  vim.enable        = true;
  git.enable        = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "konstantin";
  home.homeDirectory = "/home/konstantin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # CLI programs
    inputs.pyprland.packages."x86_64-linux".pyprland
    inputs.astal.packages."x86_64-linux".default
    nix-search-cli
    brightnessctl
    oh-my-posh
    p7zip-rar
    lsof
    lshw
    nixd

    # Dev
    vscodium
    gcc
    gh

    # Themes
    gtk3
    dconf-editor
    adwaita-icon-theme
    gruvbox-gtk-theme
    gruvbox-plus-icons
    posy-cursors

    # Images
    inkscape
    imagemagick
    
    # Media
    ffmpeg-headless
    strawberry
    loupe
    mpv

    # Games
    prismlauncher
    steam
    lutris

    # Messaging
    whatsapp-for-linux
    telegram-desktop
    teams-for-linux
    vesktop
    teamspeak5_client

    # Fonts
    powerline-fonts
    source-sans-pro
    source-sans
    source-han-sans
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  # Enable programs
  programs.firefox.enable = true;

  # Allow fonts installed via home.packages to be detected
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
