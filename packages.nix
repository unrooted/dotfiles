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
    acpilight

    # Haskell stuff
    ghc
    stack
    cabal-install
    hlint
    haskell-language-server

    # Rice
    polybarFull
    dunst
    rofi

    # Terminal emulators
    xterm
    alacritty

    # Text editors
    vim
    emacs
    xclip
    neovim

    # File managers
    ranger
    pcmanfm

    # Browsers
    firefox
    chromium
    
    # Other
    sassc
    ruby
    meson
    ncmpcpp
    vlc
    mpv

  ];
}
