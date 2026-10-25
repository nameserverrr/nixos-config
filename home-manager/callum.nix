{ pkgs, lib, ... }:

{
  imports = [
    ./git.nix
  ];

  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = ./wallpaper.png;
    };
  };

  programs.zsh.enable = true;

  home.username = "callum";
  home.homeDirectory = "/home/callum";
  home.stateVersion = "26.05";
}
