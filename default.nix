# Use "nix-shell" to create a working environment for the tools here.
# This brings "nixops" and "ssh" into scope.

{ nixpkgs ? import <nixos> {} }:

nixpkgs.pkgs.stdenv.mkDerivation {
  name = "remotexec";
  src = ./.;
  nativeBuildInputs = with nixpkgs.pkgs; [ nixops openssh ];
  installPhase = "echo done;";
}
