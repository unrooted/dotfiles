# Font list

{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    # Nerd Fonts
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
