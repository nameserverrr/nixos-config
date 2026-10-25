{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  imports = [
    ../hardware/generic.nix
  ];

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = "--keep 3";
    };
  };

  users.users.callum = {
    description = "Callum";
    isNormalUser = true;
    extraGroups = [ "dialout" "networkmanager" "wheel" "disk" "storage" ];
    password = "password";
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = [ "callum" ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "uk";
    useXkbConfig = true;
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    termius
    discord
    spotify
    firefox
    vscode-fhs
    nodejs
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };

  networking.hostName = "callum-nix"; 
  networking.networkmanager.enable = true;

  system.stateVersion = "26.05";
}
