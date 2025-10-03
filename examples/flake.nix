{
  description = "A Bitcoin Bank in cyberspace.";

  inputs.nix-bitcoin.url = "github:fort-nix/nix-bitcoin/release";
  inputs.cdk-mintd.url = "github:jurraca/cdk";

  inputs.nixpkgs.follows = "nix-bitcoin/nixpkgs";
  inputs.nixpkgs-unstable.follows = "nix-bitcoin/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
    nix-bitcoin,
    cdk-mintd,
    ...
  }: {
    nixosConfigurations.mymint = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nix-bitcoin.nixosModules.default
        cdk-mintd.nixosModules.default
        {
          imports = [ ./configuration.nix ];
        }
      ];
    };
  };
}
