{ desktop, lib, pkgs, ... }: {
  imports = [
  ]
  ++ lib.optional (builtins.pathExists (./. + "/${desktop}.nix")) ./${desktop}.nix;

  services.xserver.enable = true;
  services.libinput.enable = true;

  services.xserver = {
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
    xkb.options = "eurosign:e,caps:ctrl_modifier";
    xkb.layout = "us";
  };


  hardware.graphics = {
    enable = true;
    #driSupport = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    vlc
    kitty
    spotify
  ];

}
