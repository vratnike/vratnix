# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./services
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  #boot.zfs.passwordTimeout = 1;
  boot.zfs.requestEncryptionCredentials = false;
  networking.hostName = "fbk"; # Define your hostname.
  networking.hostId = "9eadbde9";
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.
  services.nfs.server.enable = true;
  services.locate.enable = true;
  services.locate.package = pkgs.plocate;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";

  time.timeZone = "America/Chicago";

  users.users.vratnik = {
    isNormalUser = true;
    extraGroups = [ "wheel" "storage" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree mc ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKn9eUcfn9ciGAVFx8obZ6vEwcweaplw8uS2V5DGY01T vratnik@tobenaitori-2025-04-25"
    ];
  };
  users.users.storage = {
    isNormalUser = false;
    uid = 70;
    group = "storage";
  };
  users.groups = { storage = { gid = 70; }; };

  environment.systemPackages = with pkgs; [
    speedtest-cli
    git
    tmux
    hentai-at-home
    glances
    tailscale
    rsync
  ];

  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;

  networking.nftables.enable = true;
  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedTCPPorts = [ 80 443 1777 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  system.stateVersion = "24.11";

}

