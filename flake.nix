{
  inputs = {
    nixpkgs.url = "github:nix-community/nixpkgs.lib";
  };

  outputs = { self, nixpkgs }: {
    rng = import self {
      inherit (nixpkgs) lib;
    };
  };
}
