{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    qbittorrent = {
      image = "docker.io/linuxserver/qbittorrent:5.1.0";
      autoStart = true;
      ports = [ "4747:4747" ];
      volumes = [
        "/export/fbknoana/srv/qbittorrent/appdata/:/config"
        "/export/fbknoana/srv/qbittorrent/seeding:/downloads"
      ];
      environment = {
        WEBUI_PORT = "4747";
      };
    };
  };
}
