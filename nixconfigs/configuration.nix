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
  hardware.enableRedistributableFirmware = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_14;

  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  networking.hostName = "ark"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  #networking.enableB43Firmware = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.wlp59s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak";
  };

  fonts.packages = [
    pkgs.dejavu_fonts
    pkgs.overpass
    pkgs.font-awesome
    pkgs.unifont
    pkgs.noto-fonts-cjk
  ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    audio-recorder
    bind
    clang
    colordiff
    file
    firefox
    fzf
    gcc
    gcolor2
    gdb
    gimp
    gitAndTools.gitFull
    gitAndTools.git-extras
    gh
    gnome-themes-extra
    gnupg1
    gparted
    hexchat
    htop
    hyperfine
    jmtpfs
    jq
    kitty
    libnotify
    libreoffice
    lsof
    man-pages
    networkmanagerapplet
    nodejs
    nox
    obs-studio
    p7zip
    pavucontrol
    pciutils
    python3
    qemu
    s3cmd
    subversionClient
    inetutils
    thunderbird
    unzip
    v4l-utils
    valgrind
    vim
    vlc
    vscode
    wasmtime
    wget
    zip

    xfce.thunar-volman
    xfce.xfce4-taskmanager
    xfce.xfce4-cpugraph-plugin
    xlockmore

    #river
    #fuzzel
    #foot
    #yambar
    #pamixer
    #bibata-cursors
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };
  programs.fish.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
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
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.opengl.driSupport32Bit = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  services.xserver.desktopManager.xfce.enable = true;

  #programs.xwayland.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andy = {
    description = "Andrew Kelley";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "power" "vboxusers" "audio" "docker" ];
    uid = 1000;
  };
  users.defaultUserShell = "/run/current-system/sw/bin/fish";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
