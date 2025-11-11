{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../home/vratnik/home.nix
    ./oci-containers.nix
    ./services/nginx.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/disk/by-id";
  networking.hostId = "8425e349";
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_;
  boot.initrd.kernelModules = [ 
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
   ];
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    #"vfio-pci.ids=8086:56a6,8086:4f92"
    "zfs.zfs_arc_max=8589934592"

];
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "ignore";
  virtualisation.waydroid.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
  programs.virt-manager.enable = true;
  programs.niri.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # for game support
  };
  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.keyboard.qmk.enable = true;
  networking = {
   hostName = "suzuran";
   domain = "foxgirls";
   hosts = {
  "127.0.0.1" = [ "*.suzuran.foxgirls" "suzuran.foxgirls" ];
   };
   networkmanager = {
    enable = true;
    };
  };
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.extraLocales = [ "all" ];
  services.locate.enable = true;
  services.locate.package = pkgs.plocate;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
  programs.sway.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome];
    configPackages = [ pkgs.gnome-session ];
  };
  programs.gamescope = {
  enable = true;
  capSysNice = true;
};
  programs.opengamepadui = {
    enable = true;
    powerstation.enable = true;
    inputplumber.enable = true;
    };
  services.displayManager = {
    defaultSession = "niri";
    autoLogin = {
      user = "vratnik";
      enable = true;
    };
    sddm = {
    enable = true;
    wayland.enable = true;
    };
  };
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandlePowerKeyLongPress = "poweroff";
  };
  fonts.packages = [
    pkgs.ipafont
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
  ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    #systemWide = true;
  };
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/export/sussuro/music";
    };
  };
  users.groups = {
    storage = {};
  };
  users.users.navidrome = {
    extraGroups = ["storage"];
  };
  users.users.vratnik = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "libvirtd" "pipewire" "storage" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  security.sudo.wheelNeedsPassword = false;
  security.pam.loginLimits = [{
    domain = "@users";
    item = "rtprio";
    type = "-";
    value = 1;
  }];
  environment.systemPackages = with pkgs; [ rsync 
  protonup-qt
  libreoffice-fresh kitty prismlauncher
  rofi waybar kdePackages.dolphin ranger hyprpolkitagent vial via qmk dunst sops age looking-glass-client wl-clipboard lshw virtiofsd fuzzel moonlight-qt xwayland-satellite distrobox nautilus swaybg jq file recoll];

  services.openssh.enable = true;
  services.udev.packages = with pkgs; [
    vial
    via
  ];
    services.samba = {
    enable = true;
    settings = {
      global = {
        "usershare path" = "/var/lib/samba/usershares";
        "usershare max shares" = "100";
        "usershare allow guests" = "yes";
        "usershare owner only" = "no";
      };
    };
    openFirewall = true;
  };
  /*
  environment.etc."distrobox/distrobox.conf".text = ''
  container_additional_volumes="/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro /etc/static/profiles/per-user:/etc/static/profiles/per-user:ro"
'';
*/
  networking.nftables.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedTCPPorts = [ 80 3389 5900 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  # system.copySystemConfiguration = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}

