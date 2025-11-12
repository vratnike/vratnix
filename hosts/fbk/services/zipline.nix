{
  services.zipline = {
    enable = true;
    environmentFiles = [ "/var/secrets/zipline.env" ];
  };
  services.nginx.virtualHosts = {
    "zipline.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      #proxyWebsockets = true;
      locations."/".proxyPass = "http://localhost:3000";
      extraConfig = "client_max_body_size 1024M;";
    };
  };
}
