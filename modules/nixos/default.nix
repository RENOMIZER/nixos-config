{ ... }: 

{
  imports = [
    ./gnome/gdm.nix
    ./gnome/gnome.nix
    ./greetd/greetd.nix
    ./nvidia/nvidia.nix
    ./polkit/polkit.nix
    ./zapret/zapret.nix
    ./thunar/thunar.nix
    ./tor/tor.nix
  ];
}