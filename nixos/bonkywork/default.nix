# Dell XPS 9520
{ config, lib, pkgs, username, ... }:
{
  imports = [
    ../_mixins/services/tailscale.nix
    ../_mixins/services/syncthing.nix
    ../_mixins/services/flatpak.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/virt
    ../_mixins/streaming
  ];

  hardware.bluetooth.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "usbmon" ];
  boot.extraModulePackages = [ ];
  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 0;
  };
  # See https://github.com/Mic92/envfs (for scripts to get access to /bin/bash etc.)
  services.envfs.enable = true;
  services.printing.enable = true;

  # Hdd sleep udev rule:
  services.udev.extraRules = ''
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
  '';

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/c0cc3496-da07-43c9-8090-35f2ceb264c7";
      fsType = "btrfs";
      options = [ "subvol=@nix_root" "noatime" "compress=lzo" "ssd" "space_cache=v2" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F9B6-3192";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/c0cc3496-da07-43c9-8090-35f2ceb264c7";
      fsType = "btrfs";
      options = [ "subvol=@nix_home" "noatime" "compress=lzo" "ssd" "space_cache=v2" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/c0cc3496-da07-43c9-8090-35f2ceb264c7";
      fsType = "btrfs";
      options = [ "subvol=@nix_nix" "noatime" "compress=lzo" "ssd" "space_cache=v2" ];
    };

  fileSystems."/home/patrik/bulk" =
    {
      device = "/dev/disk/by-uuid/3eb2ae50-d051-4708-a16b-b03b26f1cdb7";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  zramSwap.enable = true;

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
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    gomuks
    obs-studio
    remmina
    kicad
    prusa-slicer
    wireshark
    gimp
    qucs-s
    teams
    wkhtmltopdf
    (pkgs.python3.withPackages (ps: with ps; [ pyserial python-lsp-server ]))
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
    "electron-27.3.11"
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
  security.wrappers.dumpcap = {
    source = "${pkgs.wireshark}/bin/dumpcap";
    owner = "root";
    group = "wireshark";
    capabilities = "cap_net_raw,cap_net_admin+eip";
  };

  users.groups.wireshark = { };
}
