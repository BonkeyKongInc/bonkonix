{ config, pkgs, lib, ... }:

{
  options.services.musescore-pdf-watcher = {
    path = lib.mkOption {
      type = lib.types.path;
      description = "Path argument to pass to the Python script.";
    };

    time = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Optional time argument to pass to the Python script.";
    };

    package = lib.mkOption {
      type = lib.types.package;
      description = "Derivation of the Python script to run.";
    };
  };

  config = {
    systemd.services.musescore-pdf-watcher = {
      path = [
        pkgs.musescore
        pkgs.xorg.xvfb
        pkgs.xvfb-run
        config.services.musescore-pdf-watcher.package
      ];
      description = "MuseScore PDF Watcher Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = 5;

        Environment = [
          "PYTHONUNBUFFERED=1"
          "QT_LOGGING_RULES=qt.qml.typeregistration.warning=false"
        ];

        ExecStart = let
          args = [
            "--path" (toString config.services.musescore-pdf-watcher.path)
          ] ++ lib.optionals (config.services.musescore-pdf-watcher.time != null) [
            "--time" config.services.musescore-pdf-watcher.time
          ];
        in "${config.services.musescore-pdf-watcher.package}/bin/musescore_pdf_generator ${lib.concatStringsSep " " args}";
      };
    };
  };
}

