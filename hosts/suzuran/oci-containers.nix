{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    redroid-uma = {
      image = "docker.io/redroid/redroid:12.0.0_64only-latest";
      autoStart = false;
      ports = [ "5555:5555" ];
      volumes = [
        "/data:/data"
      ];
      environment = {
        androidboot.redroid_gpu_mode = "host";
        androidboot.use_memfd	= "true";
        androidboot.redroid_width = "1080";
        androidboot.redroid_height = "1920";
        androidboot.redroid_dpi = "480";
      };
    };
  }; 
}
