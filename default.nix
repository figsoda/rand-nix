{ lib ? import <nixpkgs/lib> }:

let
  inherit (builtins)
    genList
    hashString
    replaceStrings
    readFile
    substring
    ;
  inherit (lib)
    fix
    flip
    mod
    pipe
    replicate
    ;

  seed = replaceStrings [ "-" "\n" ] [ "" "" ]
    (readFile /proc/sys/kernel/random/uuid);

  hash = hashString "sha256";

  rng = seed: fix (self: {
    int = (fromTOML "x=0x${substring 28 8 (hash seed)}").x;

    intBetween = x: y: x + mod self.int (y - x);

    next = rng (hash seed);

    skip = flip pipe [
      (flip replicate (x: x.next))
      (pipe self)
    ];

    take = genList self.skip;

    withSeed = rng;
  });
in

rng seed
