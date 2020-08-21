{ pkgs, buildGoModule, fetchFromGitHub, stdenv, hugoVersion, sha, vendorSha }:

let
  name = "hugo";

  libsass = fetchFromGitHub {
    owner = "bep";
    repo = "golibsass";
    rev = "8a04397f0baba474190a9f58019ff499ec43057a";
    sha256 = "0xk3m2ynbydzx87dz573ihwc4ryq0r545vz937szz175ivgfrhh3";
  };
in buildGoModule {
  pname = name;
  version = hugoVersion;

  buildInputs = [ pkgs.libsass ];

  src = fetchFromGitHub {
    owner = "gohugoio";
    repo = name;
    rev = "v${hugoVersion}";
    sha256 = sha;
  };

  golibsass = libsass;

  overrideModAttrs = (_: {
    postBuild = ''
      rm -rf vendor/github.com/bep/golibsass/
      cp -r --reflink=auto ${libsass} vendor/github.com/bep/golibsass
    '';
  });

  vendorSha256 = vendorSha;

  buildFlags = [ "-tags" "extended" ];

  subPackages = [ "." ];

  meta = with stdenv.lib; {
    description = "A fast and modern static website engine.";
    homepage = "https://gohugo.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ schneefux filalex77 Frostman ];
  };
}
