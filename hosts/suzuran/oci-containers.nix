{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    lanraragi = {
      image = "difegue/lanraragi";
      autoStart = true;
      ports = [ "3000:3000" ];
      volumes = [
        "/export/sussuro/porn/lanraragi/content:/home/koyomi/lanraragi/content"
        "/export/sussuro/porn/lanraragi/thumb:/home/koyomi/lanraragi/thumb"
        "/export/sussuro/porn/lanraragi/database:/home/koyomi/lanraragi/database"
      ];
    };
  };
}
