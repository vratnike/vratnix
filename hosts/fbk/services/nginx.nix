{
  imports = [
    ./sites/
  ];
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "petrichor.moe" = {
        forceSSL = true;
        enableACME = true;
        extraConfig =
          "autoindex on; error_page 404 /404.html; charset UTF-8; override_charset on;";
        root = "/var/www/petrichor.moe/";
        locations = {
          "/" = {
            index = "index.html";
            tryFiles = "$uri $uri.html $uri/ =404";
          };
        };
      };
    };
  };
}
