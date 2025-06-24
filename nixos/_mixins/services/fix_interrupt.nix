{ pkgs, ... }:
{
  systemd.services.bonky-fixinterrupt = {
    path = [ pkgs.coreutils ];
    wantedBy = [ "multi-user.target" ];
    unitConfig = {
      Description = "Disable bad interrupt";
      After = [ "multi-user.target" ];
      #Requires = [ "local-fs.targetz" ];
      #After = [ "local-fs.target" ];
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/patrik/bonk/.fix_interrupt.sh";
      WorkingDirectory = "/home/patrik/bonk/";
      RemainAfterExit = "yes";
    };
  };
}
