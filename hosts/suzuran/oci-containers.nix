{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    redroid-uma = {
      image = "redroid/redroid:12.0.0_64only-latest";
      autoStart = true;
      ports = [ "5555:5678" ];
      volumes = [
        "/home/vratnik/data:/data"
      ];
      /*
      environment = {
        androidboot.redroid_gpu_mode = "host";
        androidboot.use_memfd	= "true";
        androidboot.redroid_width = "1080";
        androidboot.redroid_height = "1920";
        androidboot.redroid_dpi = "480";
      };
      */
    };
  }; 
}
