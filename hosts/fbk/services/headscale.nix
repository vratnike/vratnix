{ config, pkgs, ... }: {
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 5555;
    serverUrl = "https://headscale.petrichor.moe";
    settings.dns.base_domain = "vratnik.moe";
    settings = { logtail.enabled = false; };
  };
  services.nginx.virtualHosts = {
    "headscale.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:5555";
        proxyWebsockets = true;
      };
    };
  };
  environment.systemPackages = [ config.services.headscale.package ];
}
