{
  services.suwayomi-server = {
    enable = true;
    settings = { server = { port = 56709; }; };
  };
  services.nginx.virtualHosts = {
    "suwayomi.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      #proxyWebsockets = true;
      locations."/".proxyPass = "http://localhost:56709";
      extraConfig = "client_max_body_size 1024M;";
      basicAuthFile = "/var/secrets/vratnik.txt";
    };
  };
}
