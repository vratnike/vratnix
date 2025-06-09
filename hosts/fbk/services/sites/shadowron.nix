{
  services.nginx.virtualHosts = {
    "shadowron.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        root = "/export/fbknoana/srv/www/shadowron/";
      };
    };
  };
}