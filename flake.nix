{
  description = "nix home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      mkHome =
        username: homeDirectory:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
              home.stateVersion = "26.05";
            }
          ];
        };
    in
    {
      homeConfigurations = {
        "root" = mkHome "root" "/root";
        "ubuntu" = mkHome "ubuntu" "/home/ubuntu";
      };
    };
}
