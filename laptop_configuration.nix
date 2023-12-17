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

  networking.hostName = "<hostname here>"; # Define your hostname.
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

  # Set users and permissions here:
  users.users.<user here> = {
    isNormalUser = true;
    home = "<specify your home directory, /home/username>";
    description = "<your name here>";
    extraGroups = [ "wheel" ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "jp";
  services.xserver.windowManager.qtile.enable = true;
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };

  # Allow Un-free Packages
  nixpkgs.config.allowUnfree = true;

  # Packages to install go in the below code block:
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Terminal emulator.
    alacritty
    # Visually configure and set xrandr options.
    arandr
    # Password manager.
    bitwarden
    # Set the brightness of your screen. Required for Qtile.
    brightnessctl
    # Web browser.
    firefox
    # Screenshot application.
    flameshot
    # Image editor.
    gimp
    # Pull down required repositories.
    git
    # Note taking app.
    joplin-desktop
    # Office suite.
    libreoffice-fresh
    # Window manager.
    qtile
    # Visually change Pulseaudio volume and other settings.
    pavucontrol
    # Standalone compositor for `X11`. Allows features such as rounded corners in Qtile.
    picom
    # Remote software.
    rustdesk
    # App menu.
    rofi
    # Wallpaper app.
    nitrogen
    # Sync files ith ease.
    syncthing
    # Unzip any zip files received.
    unzip
    # Text editor.
    vim
    # Video player.
    vlc
    # Code editor.
    vscodium
    # Pull down files via the CLI.
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Programs to install and enable.

  # Install and enable Thunar.
  programs.thunar.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable bluetooth.

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the OpenSSH daemon.

  services.openssh.enable = true;

  # Enable tailscale.

  services.tailscale.enable = true;

  # Firewall settings.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # Initially disabled to make network troubleshooting easier. Re-enable afterwards.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
