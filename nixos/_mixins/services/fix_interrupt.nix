{ pkgs, ... }:
{
  systemd.services.bonky-fixinterrupt = {
    #path = [ "/run/wrappers/" pkgs.coreutils pkgs.gawk pkgs.syncoid pkgs.tailscale pkgs.matrix-sh pkgs.zfs pkgs.docker pkgs.curl pkgs.unixtools.ping ];
    unitConfig = {
      Description = "Disable bad interrupt";
      #Requires = [ "local-fs.targetz" ];
      #After = [ "local-fs.target" ];
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/patrik/.fix_interrupt";
    };
  };
}
