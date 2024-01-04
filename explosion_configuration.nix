# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "explosion"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
  #   keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  
  # scanner is for `scanner` and `lp` is for `printer`  
  users.users.howard = {
    isNormalUser = true;
    home = "/home/howard";
    description = "Howard Van Der Wal";
    extraGroups = [ "wheel" "audio" "sound" "scanner" "lp" ];
  };
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "jp";
  services.xserver.windowManager.qtile.enable = true;
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable autodiscovery of network printers.

  services.avahi = {
     enable = true;
     nssmdns = true;
     openFirewall = true;
  };
  
  # Enable Epson printer driver.

  services.printing.drivers = [ pkgs.epson-escpr ];
  
  # Enable Epson scanner.
  
  # Enable sane. 
  hardware.sane.enable = true;  
  # Install Epson packages.
  hardware.sane.extraBackends = [ pkgs.epkowa ]; 

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow Un-free Packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    arandr
    bitwarden
    brightnessctl
    dpkg
    firefox
    flameshot
    gimp
    git
    joplin-desktop
    libreoffice-fresh
    lsof
    qtile
    nmap
    pavucontrol
    picom
    rustdesk
    rofi
    nitrogen
    syncthing
    unzip
    vim
    vlc
    vscodium 
    wget
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Enable tailscale.

  services.tailscale.enable = true;

  # Enable tmux.

  programs.tmux = {
    enable = true;
    clock24 = true;
  };
 
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "23.05"; # Did you read the comment?
  
  # Install Japanese fonts.
  fonts.fonts = with pkgs; [
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
  ];

  # Install Japanese default fonts.
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };

 # Set up Japanese IME.
 # Configure the IME afterwards and set up mozc with `fcitx5-configtool`, add mozc and then you can use Japanese.
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
    ];
};
 
}

