# Intel N100 
{ config, lib, pkgs, ... }:
{
  imports = [
    ../_mixins/services/tailscale.nix
    ../_mixins/services/syncthing.nix
    ../_mixins/services/flatpak.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/virt
    ../_mixins/streaming
    ../_mixins/firefox
  ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "usbmon" ];
  boot.extraModulePackages = [ ];

  # See https://github.com/Mic92/envfs (for scripts to get access to /bin/bash etc.)
  services.envfs.enable = true;

  # zfs
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "c0c6d51e";
  boot.zfs.extraPools = [ "bulk" ];

  # Hdd sleep udev rule:
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[b-z]", ATTRS{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -S 120 /dev/%k"
  '';

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/707ab396-8ce5-48ca-b155-1bc80be3bf1c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/DD59-EFF8";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/aafeb3e7-fd78-4dba-a91c-7f15b2850142"; }
    ];

  #swapDevices = [ { device = "/swap/swapfile"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # In order for VSCode remote to work
  programs.nix-ld.enable = true;
  programs.talon.enable = true;
  programs.adb.enable = true;
  programs.ssh.forwardX11 = true;

  environment.systemPackages = with pkgs; [
    gomuks
    obs-studio
    remmina
    wireshark
    (pkgs.python3.withPackages (ps: with ps; [ pyserial python-lsp-server ]))
  ];
}
