{ config, lib, pkgs, nixgl, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home-manager.users.vratnik = {
    home.username = "vratnik";
    home.homeDirectory = "/home/vratnik";
    home.sessionVariables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
    #nixGL.packages = nixgl.packages;
    #nixGL.defaultWrapper = "mesa";
    #nixGL.offloadWrapper = "nvidiaPrime";
    #nixGL.installScripts = [ "mesa" ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.11"; # Please read the comment before changing.

    services.syncthing.enable = true;
    i18n.inputMethod.enabled = "fcitx5";
    i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-mozc ];
    home.packages = with pkgs; [
      floorp
      #hydrus
      alacritty
      vesktop
      htop
      anki
      #imgbrd-grabber
      (mpv-unwrapped.override { ffmpeg = ffmpeg-full; })
      dmenu
      pciutils
      git
      vscodium
      telegram-desktop
      element-desktop
      fastfetch
      glances
      obsidian
      pulsemixer
      keepassxc
      qbittorrent
      filezilla
      syncplay
      nil
      nixd
      nixfmt
      ungit
      tree
      grim
      maim
      ncdu
      imagemagick
      xdg-user-dirs
      slurp
      #tome4
      nodejs
      rclone
      mc
      tmux
      steam
      steam-run
      steam-run-native
      wineWowPackages.stable
      qimgv
      quarto
      scrcpy
      peazip
      p7zip
      xclip
      moreutils
      tor-browser
      cryfs
      tailscale
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.shell.enableShellIntegration = true;
    home.shell.enableZshIntegration = true;
    targets.genericLinux.enable = true;
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "duellj";
      };
    };
  };
}
