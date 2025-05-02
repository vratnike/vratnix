{ config, pkgs, lib, noto-fonts, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      hydrus = prev.hydrus.overrideAttrs {
        version = "620a";
        hash = "sha256-441f9f33dad8e0338645209e7b299a004f2d905a";
      };
    })
  ];
}
