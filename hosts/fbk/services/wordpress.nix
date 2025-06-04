{
  services.wordpress = {
    webserver = "nginx";
    sites = {
      "caw.petrichor.moe" = {
        settings = {
          WP_DEFAULT_THEME = "twentytwentytwo";
          WP_SITEURL = "https://caw.petrichor.moe";
          WP_HOME = "https://caw.petrichor.moe";
          WP_DEBUG = true;
          WP_DEBUG_DISPLAY = true;
          #WPLANG = "de_DE";
          FORCE_SSL_ADMIN = true;
          AUTOMATIC_UPDATER_DISABLED = true;
        };
      };
    };
  };
  services.nginx.virtualHosts = {
    "caw.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
      };
    };
  };
}
