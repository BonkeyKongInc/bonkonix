{ pkgs, desktop, darkmode, ... }:
{
  home = {
    packages = with pkgs; [
      superfile
    ];

  };
  home.file.".config/superfile/config.toml".source = ./superfile_config.toml;

  # If Superfile uses a specific hotkey configuration file
  home.file.".config/superfile/hotkeys.toml".source = ./superfile_hotkeys.toml;
}
