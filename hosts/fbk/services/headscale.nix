{ config, pkgs, ... }:
{
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 5555;
    serverUrl = "https://headscale.petrichor.moe";
    settings.dns.base_domain = "vratnik.moe";
    settings.dns.nameservers.global = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    settings = {
      logtail.enabled = false;
    };
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
