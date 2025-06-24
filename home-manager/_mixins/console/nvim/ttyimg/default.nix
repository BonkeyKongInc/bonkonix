{ pkgs, ... }:

let
  ttyimg = pkgs.buildGoModule {
    pname = "ttyimg";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "BonkeyKongInc";
      repo = "ttyimg";
      rev = "f49766193154d2b4559a22507a94205198399f22"; # Use a specific commit hash or tag
      hash = "sha256-fFZAiBwZmYa1FTajrS816tbCSstPCU2XExkeDlG2+1I=";
      #sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with the correct SHA256
    };
    vendorHash = null; # Set to null if using go modules
    #go = pkgs.go_1_23; # Use Go 1.23 (latest available)

    #overrideAttrs = [go = pkgs.go_1_23_3];  # Override Go version to 1.23.3](oldAttrs: {

  };
in
{
  home.packages = with pkgs; [
    ttyimg
  ];
}

