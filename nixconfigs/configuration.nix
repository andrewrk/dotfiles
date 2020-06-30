# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # needed for the wifi firmware
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_5_4;

  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.hostName = "ark"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.enableB43Firmware = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    clang
    colordiff
    file
    firefox
    fzf
    gcc
    gcolor2
    gdb
    gimp
    git
    gitAndTools.git-extras
    gnome-themes-standard
    gnupg1
    gparted
    hexchat
    htop
    jmtpfs
    jq
    libnotify
    libreoffice
    lsof
    manpages
    networkmanagerapplet
    nodejs
    nox
    obs-studio
    pavucontrol
    pciutils
    python3
    qemu
    s3cmd
    subversionClient
    telnet
    thunderbird
    unzip
    valgrind
    vim
    vlc
    wasmtime
    wget
    xfce4-14.thunar-volman
    xfce4-14.xfce4-taskmanager
    xfce.xfce4-cpugraph-plugin
    xlockmore
    zip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gtk2";
  };
  programs.fish.enable = true;

  # List services that you want to enable:

  #services.openssh.enable = true;
  services.ntp.enable = true;
  services.dbus.enable = true;
  services.udisks2.enable = true;
  services.udev.packages = [ pkgs.libmtp.bin ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable sound.
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.enableRedistributableFirmware = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    #videoDrivers = [ "nvidia" ];
    layout = "us";
    desktopManager.xfce.enable = true;

    # synaptics = {
    #   enable = true;
    #   twoFingerScroll = true;
    #   additionalOptions = ''
    #     Option "ClickPad" "true"
    #     Option "EmulateMidButtonTime" "0"
    #     Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
    #   '';
    # };
  };
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andy = {
    description = "Andrew Kelley";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "power" "vboxusers" "audio" "docker" ];
    uid = 1000;
  };
  users.defaultUserShell = "/run/current-system/sw/bin/fish";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
