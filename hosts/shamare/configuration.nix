{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #../../home/vratnik/home.nix
    ./services/oci-containers.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  nix = {
    #package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.kvmgt.enable = true;
  virtualisation.kvmgt.vgpus = {
    i915-GVTg_V5_4 = { uuid = [ "a7a04f68-304c-11f0-bf3c-b3e7f616c367" ]; };
  };
  programs.virt-manager.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # for game support
  };
  hardware.firmware = [ pkgs.linux-firmware ];
  networking.hostName = "shamare";
  networking.domain = "foxgirls";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.extraLocales = [ "all" ];
  services.locate.enable = true;
  services.locate.locate = pkgs.plocate;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
  #services.xserver.enable = true;
  #services.xserver.windowManager.i3.enable = true;
  programs.niri.enable = true;
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
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "poweroff";
  };
  services.throttled.enable = true;
  services.thermald.enable = true;
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
  # services.libinput.enable = true;
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
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
  };
  environment.systemPackages = with pkgs; [ rsync libreoffice-fresh bluez alacritty fuzzel swaylock spotify pulsemixer waybar brave vesktop signal-desktop element-desktop nautilus swaybg obsidian xwayland-satellite];

  services.openssh.enable = true;
  networking.nftables.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedTCPPorts = [ 3389 5900 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  # system.copySystemConfiguration = true;
  system.stateVersion = "25.05"; # Did you read the comment?

}

