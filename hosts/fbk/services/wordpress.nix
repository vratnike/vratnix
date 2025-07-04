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
  services.phpfpm.pools."caw.petrichor.moe".user = "nginx";
  services.phpfpm.pools."caw.petrichor.moe".phpOptions = ''
  upload_max_filesize=1G
  post_max_size=1G
'';
  services.nginx.virtualHosts = {
    "caw.petrichor.moe" = {
      forceSSL = true;
      enableACME = true;
      extraConfig = "client_max_body_size 1024M;";

    };
  };
}
