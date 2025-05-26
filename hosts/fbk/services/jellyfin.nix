{
  services.jellyfin.enable = true;
  services.nginx.virtualHosts = {
    "jellyfin.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
      };
    };
  };
}