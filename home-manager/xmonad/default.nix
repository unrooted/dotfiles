{ config, pkgs, lib, ... }:
let
  extraPackages = import ./extraPackages.nix;
in
{
  # lib.mkOption = {
    # description = "Enable custom vim configuration.";
    # type = with lib.types; bool;
  # };

  # config = lib.mkIf cfg.enable {

    home.file.".xmobarrc".source = ./xmobar.hs;
    xsession.windowManager.xmonad = {
      inherit extraPackages;
      enable = true;
      config = ./xmonad.hs;
    };
    xsession.profileExtra = ''export $(dbus-launch)'';
    xsession.enable = true;
    home.file.".wallpaper.jpg".source = ./wallpaper.jpg;
  # };
}
