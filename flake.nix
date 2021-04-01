{
  description = "A highly awesome system configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur.url = github:nix-community/NUR;
    home-manager = { url = github:nix-community/home-manager/master; inputs.nixpkgs.follows = "nixpkgs"; };
    doom-emacs.url = "github:vlaci/nix-doom-emacs";
  };

  outputs = inputs@{ self, nur, home-manager, nixpkgs, doom-emacs, ... }:
    let
      inherit (nixpkgs) lib;
      inherit (lib) recursiveUpdate;
      system = "x86_64-linux";
      my-pkgs = import ./overlays;

      utils = import ./utility-functions.nix {
        inherit lib system pkgs inputs self;
        nixosModules = self.nixosModules;
      };

      pkgs = utils.pkgImport nixpkgs []; # self.overlays
    in
    {
      nixosModules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          nixpkgs.config.allowUnfree = true;
          home-manager.users.unrooted = { imports = [ ./home-manager/home.nix doom-emacs.hmModule ];
          };
        }
      ];

      nixosConfigurations = utils.buildNixosConfigurations [
        ./configurations/NaughtyOne.host.nix
      ];

      # overlay = my-pkgs;
      # overlays = [
        # my-pkgs
      # ];

    };
}
