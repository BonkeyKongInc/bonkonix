{ config, pkgs, lib, darkmode, ... }: {
  imports = [
    ./tmux.nix
    ./zsh.nix
    ./git.nix
    ./nvim
    #    ./nvim/ttyimg
    ./superfile.nix
  ];
  home = {
    file = {
      "${config.xdg.configHome}/starship.toml".text = builtins.readFile ./newstarship.toml;
    };

    # common cli apps for all hosts
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
      tokei
      du-dust
      radare2
      wireguard-tools
      jq
      dig
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
      gcc-arm-embedded-13
      nmap
      iperf
      meson
      pkg-config
      mdr
      ninja
      obsidian
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
