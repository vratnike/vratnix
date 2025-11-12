{
  imports = [
    #./sites
  ];
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "navidrome.suzuran.foxgirls" = {
        locations."/".proxyPass = "http://localhost:4533";
      };
    };
  };
}
