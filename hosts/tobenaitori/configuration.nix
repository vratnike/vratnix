# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../home/vratnik/home.nix
    ./services/oci-containers.nix
  ];
  environment.variables = {
    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
    FONTCONFIG_PATH = "${pkgs.fontconfig.out}/etc/fonts/";
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  nix = {
    #package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # for game support
  };
  hardware.firmware = [ pkgs.linux-firmware ];
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ steam-run steam steam-unwrapped libglvnd libGLU ];
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  networking.hostName = "tobenaitori";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "ja_JP.UTF-8";
  services.locate.enable = true;
  services.locate.locate = pkgs.plocate;
  services.tailscale.enable = true;
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager = {
    defaultSession = "none+i3";
    autoLogin = {
      user = "vratnik";
      enable = true;
    };
    lightdm.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals =
    [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  xdg.portal.config.common.default = "gtk";
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
    extraGroups =
      [ "wheel" "adbusers" "libvirtd" ]; # Enable ‘sudo’ for the user.
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
  environment.systemPackages = with pkgs; [ ];

  # services.openssh.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  # system.copySystemConfiguration = true;
  system.stateVersion = "25.05"; # Did you read the comment?

}

