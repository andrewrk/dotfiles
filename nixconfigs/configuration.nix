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
  nixpkgs.config.pulseaudio = true;

  time.timeZone = "US/Arizona";

  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    cleanTmpDir = true;
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };

    # sadly disabling overcommit breaks apps such as chromium browser.
    #kernel.sysctl = {
    #  "vm.overcommit_memory" = 2; # disable overcommit
    #};

  };

  fileSystems."/extra" = {
    label = "extra";
    fsType = "ext4";
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
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  virtualisation.virtualbox.host.enable = true;

  services = {
    ntp.enable = true;
    locate.enable = true;
    dbus.enable = true;
    udisks2.enable = true;
    udev.packages = [ pkgs.libmtp ];
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
    rtkit.enable = true;

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
    blender
    #cargo
    chromium
    clang
    colordiff
    cowsay
    file
    firefox
    gcolor2
    gimp
    git
    git-hub
    gitAndTools.git-extras
    gcc5
    gdb
    glxinfo
    gnupg1
    gparted
    handbrake
    hexchat
    htop
    inkscape
    iotop
    jack2Full
    jmtpfs
    libnotify
    lsof
    manpages
    mpv
    mupdf
    networkmanagerapplet
    pciutils
    nodejs
    nox
    p7zip
    pavucontrol
    pidgin
    powertop
    psmisc
    python
    python3
    qjackctl
    ruby
    rustc
    s3cmd
    simplescreenrecorder
    sonic-visualiser
    subversionClient
    synthv1
    telnet
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
    zip
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
