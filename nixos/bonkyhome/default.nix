# Sony Vaio SVS1313C5E 
{ config, lib, pkgs, ... }:
{
  imports = [
    ../_mixins/services/tailscale.nix
    ../_mixins/services/syncthing.nix
    ../_mixins/services/flatpak.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/virt
    ../_mixins/services/fix_interrupt.nix
    ../_mixins/streaming
    ../_mixins/firefox
  ];

  hardware.bluetooth.enable = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "usbmon" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  # See https://github.com/Mic92/envfs (for scripts to get access to /bin/bash etc.)
  services.envfs.enable = true;

  # Hdd sleep udev rule:
  services.udev.extraRules = ''
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
  '';

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ede3ff8b-676f-48d7-a87a-adf610d7bf72";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ed7ae231-863c-44e6-922b-08854c9276d0"; }
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

  environment.systemPackages = with pkgs; [
    gomuks
    obs-studio
    remmina
    kicad
    prusa-slicer
    wireshark
    reaper
    alacritty
    cpufrequtils
    #    cockpit
    #    cockpit.podman
    #    cockpit.storaged
    obsidian
    wine

    (pkgs.python3.withPackages (ps: with ps; [ pyserial python-lsp-server ]))
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
    "electron-27.3.11"
  ];
  systemd.services.increaseCpu = {
    description = "Enables usage of max cpu freq";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "cpufreq-set -f $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)";
      Type = "simple";
      Restart = "always";
    };
};
  services.cockpit.enable = true;
}
