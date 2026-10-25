{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name  = "nameserverrr";
      user.email = "cxllum.0381@gmail.com";
      push.autoSetupRemote = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}
