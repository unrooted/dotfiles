# Package list

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Basic CLI
    bash
    zsh
    git
    wget
    zip
    unzip
    htop
    coreutils
    killall
    usbutils
    ntfs3g
    ripgrep
    ripgrep-all
    exa
    acpilight

    # Haskell stuff
    ghc
    stack
    cabal-install
    hlint
    haskell-language-server

    # Terminal emulators
    st
    alacritty

    # Text stuff
    vim
    emacs

    # File managers
    ranger
    pcmanfm

    # Browsers
    firefox
    chromium
    surf

    # window managers
    xmobar
    picom
    dmenu
    stalonetray
    xfce.xfce4-power-manager
    feh
    
    # Other
    meson
    ncmpcpp
    vlc
    mpv
    mpd
    flameshot
    zathura
    udiskie
    python39

  ];
}
