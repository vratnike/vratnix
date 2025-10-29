{ pkgs,lib, config, ...}:
let
  clientConfig."m.homeserver".base_url = "matrix.petrichor.moe";
  serverConfig."m.server" = "matrix.petrichor.moe";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  services.postgresql.enable = true;

  services.nginx.virtualHosts."matrix.petrichor.moe" = {
        enableACME = true;
        forceSSL = true;
        locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
        locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
        locations."/".extraConfig = ''
          return 404;
        '';
        locations."/_matrix".proxyPass = "http://[::1]:8008";
        locations."/_synapse/client".proxyPass = "http://[::1]:8008";
      };

  services.matrix-synapse = {
    enable = true;
    settings.server_name = "matrix.petrichor.moe";
    settings.public_baseurl = "matrix.petrichor.moe";
    settings.listeners = [
      {
        port = 8008;
        bind_addresses = [ "::1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [
          {
            names = [
              "client"
              "federation"
            ];
            compress = true;
          }
        ];
      }
    ];
    extraConfigFiles = [ "/var/secrets/synapse.txt" ];
  };
}