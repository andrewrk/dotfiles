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
  nixpkgs.config.virtualbox.enableExtensionPack = true;

  time.timeZone = "US/Arizona";

  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    cleanTmpDir = true;
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };

  };

  networking = {
    hostName = "nixos";
    hostId = "83e4728c";
    networkmanager.enable = true;
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
  };
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    layout = "us";
    xkbOptions = "eurosign:e";
    synaptics = {
      enable = true;
      twoFingerScroll = true;
      additionalOptions = ''
        Option "ClickPad" "true"
        Option "EmulateMidButtonTime" "0"
        Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
      '';
    };
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
    cargo
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
    handbrake
    htop
    iotop
    jmtpfs
    manpages
    networkmanagerapplet
    nodejs
    nox
    p7zip
    pavucontrol
    psmisc
    python
    python3
    rustc
    s3cmd
    simplescreenrecorder
    synthv1
    unzip
    upx
    valgrind
    vlc
    wget
    xdg-user-dirs
    xchat
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
    extraGroups = [ "wheel"  "networkmanager" "video" "power" "vboxusers" "audio" ];
    uid = 1000;
  };

}
