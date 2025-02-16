{ config, pkgs, lib, darkmode, ... }: {
  imports = [
    ./tmux.nix
    ./zsh.nix
    ./git.nix
    ./nvim
  ];
  home = {
    file = {
      "${config.xdg.configHome}/starship.toml".text = builtins.readFile ./newstarship.toml;
    };

    packages = with pkgs; [
      tldr
      starship
      fzf
      neofetch
      ripgrep
      eza
      fd
      bat
      delta
      btop
      tmux
      age
      bitwarden-cli
      key_extractor
      tokei
      du-dust
      radare2
      wireguard-tools
      jq
      dig
      #matrix-sh
      #wl-clipboard
      xclip
#      gitFull
     # gitg
      gcc
      llpp
      #gfortran
      speedcrunch
      python311Packages.numpy
      python311Packages.libxml2
      python311Packages.libxslt
      python311Packages.pynvim
      libxslt
      libxml2
      cmake
      libclang
      gparted
      parted
      rpiboot
      pinta
      microsoft-edge
      htop
      scrcpy
      libreoffice
      gcc-arm-embedded-9
      nmap
      iperf
      #astyle
      meson
      pkg-config
      mdr
    ];


    sessionVariables = {
      EDITOR = "vim";
      SYSTEMD_EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  programs.starship = {
    enable = false;
  };

  programs.bat = {
    enable = true;
    config.theme = "1337";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
