{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.profiles.dev;
  haskellPack = with pkgs.haskellPackages; 
    let
      ps = p: with p;  [ async base containers lens mtl random stm text transformers unliftio ];
      ghc = ghcWithHoogle ps;
    in [
      ghc
      cabal-install
      hlint
      ghcide
      hnix
      stack
      haskell-language-server
    ];
  devPack = with pkgs; [
    opam
    cmake
    clang
    universal-ctags
    nasm
    idea.idea-community
    gdb
    binutils
    coq
    gnumake
    openssl
    patchelf
    # scala
    # sbt
    # metals
    jq
    # pkgsCross.avr.buildPackages.gcc
    pkgconfig
  ];
  appPack = with pkgs; [
    element-desktop
    zathura
    feh
    mplayer
    torbrowser
    slack
    weechat
    gmp.static.dev
    spotify
    libreoffice
    dmenu
    sxiv
  ];
  mediaPack = with pkgs; [
    noip
    remmina
    pavucontrol
    flameshot
    firefox
    chromium
    tdesktop
    mpv
    mpd
    vlc
    # wine
    # wineFull
    youtube-dl
    lm_sensors
    liblqr1
    zlib.dev
  ];
  cliPack = with pkgs; [
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
    pciutils
    ntfs3g
    acpilight
  ];
  texPack = with pkgs;
    [
      pdftk
      (
        texlive.combine {
          inherit (texlive) scheme-medium lipsum fmtcount datetime;
        }
      )
    ];
  languageserverPack = with pkgs; [
    shellcheck
    rnix-lsp
    nixfmt
    clang-tools
  ];
in
{
  options.profiles.dev.enable =
    lib.mkOption {
      description = "Enable custom vim configuration.";
      type = with lib.types; bool;
      default = true;
    };
  config = lib.mkIf cfg.enable {
    home.packages = builtins.concatLists [
      haskellPack
      devPack
      appPack
      mediaPack
      cliPack
      texPack
      languageserverPack
    ];
  };

}
