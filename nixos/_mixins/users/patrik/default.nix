{ config, desktop, lib, pkgs, ... }:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # Only include desktop components if one is supplied.
  imports = [ ] ++ lib.optional (builtins.isString desktop) ./desktop.nix;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  users.users.patrik = {
    isNormalUser = true;
    initialPassword = "a";
    openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD7CuKe+2ySr6+RTSESNSmdlc5nX2haMk1Azk1YTLIs6vG4lKBP4gIFGz1DJD4TkAL/UStGGFuraIN96OvCTViXTUQK/Oa/plBHQoW17PLs9xBinrseXUnEFaDoq7wR+QD6sGxT6zueBEWWGfnVL1cDxmNdT48qSHQgrD/vGYsMF++EpHa8e8WRqyAqDnYW52h/zSxxbGemMuxKsYWVcpiVceGi9CjHxeXXnJxa6ZnoVz35CIahAYZQSr6hPK0RYBPfznk1zO8bBdb0euxUd8VGZS/BiNrUYzHfUiZ91NAv2BKdCJHoieXNjE6bKCpHoa4JZwLKcBFTWqtrVlA7yY01cNtJZExEHtxwAYbbBiDegezoZZNkpTVSnlmZl07eVdFIn3cEKhNZZkZCPHnCBGKhVTkJMj8rd+8tSSE6EdSjRUUYThMSXU0krGQtxcBLzouDiWOiG6OfKeh8izuLOssGkJk8NhGJTwts5VzshL9oIG+0EPmyHEKhuFzfRtApeFc= "
    ];
    extraGroups = [
      "wheel"
      "dialout"
      "plugdev"
    ] # Enable ‘sudo’ for the user.
    ++ ifExists [
      "docker"
      "podman"
      "jellyfin"
      "wireshark"
      "libvirtd"
      "adbusers"
    ];
    packages = with pkgs; [
      firefox
      tree
    ];
    shell = pkgs.zsh;
  };
}
