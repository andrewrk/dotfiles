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
    kernelPackages = pkgs.linuxPackages_latest;
    cleanTmpDir = true;
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
      splashImage = ./penguin.png;
    };
  };

  networking = {
    hostName = "nixos";
    hostId = "83e4728c";
    networkmanager.enable = true;
  };

  services = {
    ntp.enable = true;
    locate.enable = true;
    dbus.enable = true;
  };
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    layout = "us";
    xkbOptions = "eurosign:e";
    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    clang
    file
    firefox
    gimp
    git
    gcc
    gnumake
    htop
    iotop
    networkmanagerapplet
    nodejs
    nox
    python3
    vimHugeX
    wget
    xdg-user-dirs
    xchat
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
    extraGroups = [ "wheel"  "networkmanager" "video" "power" "vboxusers" ];
    uid = 1000;
  };

}
