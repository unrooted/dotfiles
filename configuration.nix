# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include the package list.
      ./packages.nix
      # Include the font list.
      ./fonts.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hardware
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport = true;
  };

  # Networking
  networking = { 
    hostName = "NaughtyOne";
    networkmanager.enable = true; 
    firewall.enable = true;
    firewall.allowPing = true;
    # firewall.allowedUDPPorts = [];
    # firewall.allowedTCPPorts = [];
  };

  # Timezone
  time.timeZone = "Europe/Warsaw";

  # Network Proxy
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  # X config
  services.xserver = {
    enable = true;
    layout = "pl";
    libinput.enable = true;
    videoDrivers = [ "modesetting"  ];
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
  };

  # CUPS
  services.printing.enable = true;

  # Sound
  sound.enable = true;

  # User accounts
  users.users.unrooted = {
    isNormalUser = true;
    home = "/home/unrooted";
    description = "Konrad Unrooted";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  # Time
  services.timesyncd = {
    enable = true;
    servers = [ "pl.pool.ntp.org"  ];
  };

  # Virtualization/other OS's support
  virtualisation.docker = {
    enable = true;
  };

  # OpenSSH daemon
  # services.openssh.enable = true;

  system.stateVersion = "21.03";

}

