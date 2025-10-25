{ lib , pkgs }:

with lib;

pkgs.stdenv.mkDerivation {
  pname = "musescore-pdf-watcher";
  version = "1.0";

  # Dependencies for building/running
    buildInputs = [
    (pkgs.python312.withPackages(ps: with ps; [ ps.watchdog ]))
  ];

  # Dependencies that downstream users (or the service) will need
  propagatedBuildInputs = [
    pkgs.xorg.xvfb
    pkgs.xvfb-run
    pkgs.musescore
  ];
  src = ./musescore_pdf_generator.py;
  dontUnpack = true;                    # must add this for a single file
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 ${./musescore_pdf_generator.py} $out/bin/musescore_pdf_generator
    '';

  meta = with pkgs.lib; {
    description = "Watcher for generating PDFs from MuseScore files";
    license = licenses.mit;
  };
}

