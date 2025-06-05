{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, hyprland
}:

stdenv.mkDerivation rec {
  pname = "hyprpanel";
  version = "unstable-2025-06-05";

  src = fetchFromGitHub {
    owner = "Jas-SinghFSU";
    repo = "HyprPanel";
    rev = "20532ee760fdf492afcf987ae091497a37878197"; # Use an actual commit hash
    sha256 = "sha256-NNGvih5zDjic+UVxm+1YYQMgRok6PcdNE0/6vzs+XrM="; # Use `nix-prefetch`
  };
  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ hyprland ];

  mesonFlags = [
    "-Dhyprland_include=${hyprland}/include"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp build/hyprpanel.so $out/lib/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Plugin panel for Hyprland";
    homepage = "https://github.com/Jas-SinghFSU/HyprPanel";
    license = licenses.gpl3Plus; # or actual license if different
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
