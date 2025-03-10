{ pkgs, ... }:

let
  ttyimg = pkgs.buildGoModule {
    pname = "ttyimg";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "Skardyy";
      repo = "ttyimg";
      rev = "7864eae"; # Use a specific commit hash or tag
      hash = "sha256-wCIEwqFouiSQFKfZATbWYYhtkY2WFl0M9FABuzeudpc=";
      #sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with the correct SHA256
    };
    vendorHash = null; # Set to null if using go modules
    go = pkgs.go_1_23_6; # Use Go 1.23 (latest available)
  };
in
{
  home.packages = with pkgs; [
    ttyimg
  ];
}
