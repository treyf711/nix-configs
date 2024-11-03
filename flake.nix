{
  description = "One Flake to Rule Them All";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, disko, ... }@inputs: {
    nixosConfigurations.knowhere = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./machines/servers/knowhere.nix ];
    };
    nixosConfigurations.jovian = nixpkgs-unstable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./machines/handhelds/jovian.nix ];
    };
  };
}
