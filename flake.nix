{
  description = "nix home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 컴파일은 nixpkgs 의 stable rust, 포맷만 nightly rustfmt 를 쓴다.
    # (Google Rust 스타일 가이드의 imports_granularity 등은 nightly 전용 옵션)
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      fenix,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      mkHome =
        username: homeDirectory:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            rustfmtNightly = fenix.packages.${system}.latest.rustfmt;
          };
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
