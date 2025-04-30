{
  services.thelounge = {
    enable = true;
    extraConfig = {
      reverseProxy = true;
      prefetch = true;
      prefetchStorage = true;
      prefetchMaxImageSize = 10000;
      fileUpload.enable = true;
      fileUpload.maxFileSize = -1;
    };
  };
  services.nginx.virtualHosts = {
    "thelounge.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      #proxyWebsockets = true;
      locations."/".proxyPass = "http://localhost:9000";
      extraConfig = "client_max_body_size 1024M;";
    };
  };
}
