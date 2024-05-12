{
  description = "Bonkonix NixOS flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # You can access packages and modules from different nixpkgs revs at the
    # same time. See 'unstable-packages' overlay in 'overlays/default.nix'.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";
    nix-formatter-pack.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    talon-nix.url = "github:nix-community/talon-nix";
    talon-nix.inputs.nixpkgs.follows = "nixpkgs";

    darkmode_flag.url = "github:boolean-option/true";

  };
  outputs =
    { self
    , nix-formatter-pack
    , home-manager
    , nixpkgs
    , nixos-hardware
    , agenix
    , talon-nix
    , darkmode_flag
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "23.11";

      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
      darkmode = darkmode_flag.value;
    in
    {
      inherit lib;
      # nix fmt
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      # The home-manager configurations (e.g): home-manager switch --flake ~/dev/ripxonix/#ripxorip@ripxowork
      homeConfigurations = {
        "patrik@bonkywork" = lib.homeManagerConfiguration {
          modules = [
            ./home-manager
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs stateVersion darkmode;
            desktop = "plasma";
            hostname = "bonkywork";
            platform = "x86_64-linux";
            username = "patrik";
          };
        };
        "patrik@bonkyhome" = lib.homeManagerConfiguration {
          modules = [
            ./home-manager
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs stateVersion darkmode;
            desktop = "plasma";
            hostname = "bonkyhome";
            platform = "x86_64-linux";
            username = "patrik";
          };
        };
      };

      # The NixOS configurations
      nixosConfigurations =
        let
          iso_params = {
            services.xserver.displayManager.autoLogin.user = lib.mkForce "patrik";
            isoImage.squashfsCompression = "gzip -Xcompression-level 1";
          };
        in
        {
          bonkywork = lib.nixosSystem {
            modules = [
              ./nixos
              agenix.nixosModules.age
              nixos-hardware.nixosModules.dell-xps-15-9520-nvidia
              talon-nix.nixosModules.talon
            ];
            specialArgs = {
              inherit inputs outputs stateVersion;
              hostname = "bonkywork";
              username = "patrik";
              desktop = "plasma";
            };
          };
          bonkyhome = lib.nixosSystem {
            modules = [
              ./nixos
              agenix.nixosModules.age
              #nixos-hardware.nixosModules.dell-xps-15-9520-nvidia
              talon-nix.nixosModules.talon
            ];
            specialArgs = {
              inherit inputs outputs stateVersion;
              hostname = "bonkyhome";
              username = "patrik";
              desktop = "plasma";
            };
          };
          # Build using: nix build .#nixosConfigurations.iso-desktop.config.system.build.isoImage 
          # Handy debug tip: nix eval .#nixosConfigurations.iso-desktop.config.isoImage.squashfsCompression
          iso-desktop = lib.nixosSystem {
            modules = [
              ./nixos
              agenix.nixosModules.age
              (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix")
              iso_params
              home-manager.nixosModules.home-manager
              {
                home-manager.users.patrik = {
                  imports = [
                    ./home-manager
                  ];
                };
                home-manager.extraSpecialArgs = {
                  inherit inputs outputs stateVersion darkmode;
                  desktop = "gnome";
                  hostname = "iso-desktop";
                  username = "patrik";
                };
              }
            ];
            specialArgs = {
              inherit inputs outputs stateVersion darkmode;
              hostname = "iso-desktop";
              username = "patrik";
              desktop = "gnome";
            };
          };
        };
    };
}
