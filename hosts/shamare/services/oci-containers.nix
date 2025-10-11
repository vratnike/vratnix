{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    /*
    kubo = {
      image = "docker.io/ipfs/kubo:v0.35.0-rc1";
      autoStart = true;
      ports = [ "4001:4001" "5001:5001" "8080:8080" ];
      volumes = [
        "/export/tobenaitori/var/ipfs/ipfs_staging/:/export"
        "/export/tobenaitori/var/ipfs/ipfs_data:/data/ipfs"
      ];
      environment = {
        ipfs_staging = "/export/tobenaitori/var/ipfs/ipfs_staging/";
        ipfs_data = "/export/tobenaitori/var/ipfs/ipfs_data";
      };
    };
    */
  };
}
