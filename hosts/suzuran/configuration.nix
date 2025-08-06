{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../home/vratnik/home.nix
    ./oci-containers.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/disk/by-id";
  networking.hostId = "8425e349";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.initrd.kernelModules = [ 
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
   ];
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "vfio-pci.ids=8086:56a6,8086:4f92"

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
  programs.virt-manager.enable = true;
  programs.hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # for game support
  };
  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.keyboard.qmk.enable = true;
  networking = {
   nameservers = [ "127.0.0.1" "::1" ];
   hostName = "suzuran";
   networkmanager = {
    enable = true;
    dns = "none";
  };
  };
  services.dnscrypt-proxy2.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.extraLocales = [ "all" ];
  services.locate.enable = true;
  services.locate.locate = pkgs.plocate;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
  #services.xserver.enable = true;
  #services.xserver.windowManager.i3.enable = true;
  programs.sway.enable = true;
  services.xserver.displayManager = {
    defaultSession = "hyprland";
    autoLogin = {
      user = "vratnik";
      enable = true;
    };
    sddm = {
    enable = true;
    wayland.enable = true;
    };
  };
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "poweroff";
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
    pulse.enable = true;
  };
  users.users.vratnik = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "libvirtd" ];
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
  libreoffice-fresh kitty
  rofi waybar kdePackages.dolphin ranger hyprpolkitagent vial via qmk dunst sops age looking-glass-client  wl-clipboard lshw ];

  services.openssh.enable = true;
  services.udev.packages = with pkgs; [
    vial
    via
  ];
  networking.nftables.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedTCPPorts = [ 3389 5900 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  # system.copySystemConfiguration = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}

