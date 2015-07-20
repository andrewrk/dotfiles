# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.virtualbox.enableExtensionPack = true;

  time.timeZone = "US/Arizona";

  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    cleanTmpDir = true;
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sdb";
    };

  };

  fileSystems."/store" = {
    label = "store";
    fsType = "ext4";
  };

  networking = {
    hostName = "nixos-desktop";
    hostId = "49c3bfa1";
    networkmanager.enable = false;
    interfaces.eno1.ip4 = [
      {
        address = "192.168.1.100";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.1.1";
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall.enable = false;
  };

  hardware = {
    opengl = {
      driSupport32Bit = true;
    };
    #pulseaudio = {
    #  enable = true;
    #};
  };

  services = {
    ntp.enable = true;
    locate.enable = true;
    dbus.enable = true;
    virtualboxHost.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    znc = {
      enable = true;
      user = "andy";
      mutable = true;
      dataDir = "/home/andy/.znc/";
    };
    lighttpd = {
      enable = true;
      port = 8888;
      "document-root" = "/store/www";
      extraConfig = ''
        dir-listing.activate = "enable"
      '';
    };
    transmission = {
      enable = true;
      port = 9091;
      settings = {
        "download-dir" = "/store/torrent";
        "speed-limit-up" = 100;
        "speed-limit-up-enabled" = true;
        "rpc-authentication-required" = true;
        "rpc-password" = "{24df632380dbd8c58f14049e19258389e7026cd0m8RcN3bs";
        "rpc-username" = "andrewrk";
        "rpc-whitelist-enabled" = false;
      };
    };
  };
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    layout = "us";
    xkbOptions = "eurosign:e";
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
  };

  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;

    pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
      { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
      { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
    ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ardour
    audacity
    bind
    #cargo
    chromium
    clang
    colordiff
    file
    firefox
    gimp
    git
    git-hub
    gitAndTools.git-extras
    gcc5
    gdb
    glxinfo
    gnupg
    gparted
    handbrake
    hexchat
    htop
    iotop
    jmtpfs
    manpages
    networkmanagerapplet
    nodejs
    nox
    p7zip
    pavucontrol
    pciutils
    psmisc
    python
    python3
    rustc
    s3cmd
    screen
    simplescreenrecorder
    synthv1
    unzip
    upx
    valgrind
    vlc
    wget
    xdg-user-dirs
    xlibs.xev
    xfce.thunar_volman
    xfce.xfce4_systemload_plugin
    xfce.xfce4_cpufreq_plugin
    xfce.xfce4_cpugraph_plugin
    xfce.xfce4_power_manager
    xfce.xfce4taskmanager
    xlockmore
  ];


  programs.bash.enableCompletion = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.andy = {
    isNormalUser = true;
    description = "Andrew Kelley";
    extraGroups = [ "wheel"  "networkmanager" "video" "power" "vboxusers" "audio" "transmission" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0fL6z+FD6aKI43RGCAyr7TUuwYDkyAftsQMWqBrQoYci/Ru0hdhUwMXopqcwcaOpTxzB06F+YZ6cYWYtKOTh+mTgac1x9o4F6cOe1zEAN7fYFUWsm1e4lFBpjG7uGx8fZSzUDRa52G+2fgubPDz7lsCJBCSPN58yjSjg2zF6UP/COOY3bdQwuU62bUR6y8KT6Vx69PCcU0ayPvN3GOoLsw5S8MpjgxN0zG7eP/bNgs0FFWj+e7QSWXh2Bp+aVLhxnGGbka8OPg4Ndr+DejAegfVzyuYlCiH6HXitN0f+MpNBUVA4PTj21R57bjq5xNlcm85XY/yYSG5QRenNrMlwPw== andy@laptop" ];
  };
}

