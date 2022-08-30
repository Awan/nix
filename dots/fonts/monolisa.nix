{lib, stdenvNoCC, ...}:

stdenvNoCC.mkDerivation {
  name = "monolisa";
  src = ./monolisa;
  dontBuild = true;
  installPhase = ''
    install -m 755 -d $out/share/fonts/truetype
    install -m 444 *.ttf $out/share/fonts/truetype/
  '';
}
