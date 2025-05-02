{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      hydrus-client = prev.hydrus-client.overrideAttrs {
        version = "620a";
        src = final.fromGithub {
          hash = "sha256-441f9f33dad8e0338645209e7b299a004f2d905a";
        };
      };
    })
  ];
}
