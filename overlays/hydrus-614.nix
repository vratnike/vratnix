{ config, pkgs, lib, noto-fonts, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      hydrus = prev.hydrus.overrideAttrs {
        version = "614";
        hash = "sha256-7UYi2dbpoGy373akOKFJjssxMdCKjpv4IgPMqBoe93Q=";
      };
    })
  ];
}
