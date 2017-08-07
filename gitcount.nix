{ pkgs ? import <nixpkgs> {} }:

# This is a very simple derivation that simply installs the local bash
# script verbatim.

pkgs.stdenv.mkDerivation {
  name = "gitcount";
  unpackPhase = "true";
  buildPhase = "";
  src = ./gitcount.sh;
  installPhase =
    ''
    set -x
    mkdir -p $out/bin
    cp $src $out/bin/gitcount
    chmod +x $out/bin/gitcount
    set +x
    '';

  # Because this script will be used as the "shell" for the captive
  # login, identify this as a useable shell.
  passthru = {
    shellPath = "/bin/gitcount";
  };
}
