{ lib ? import <nixpkgs/lib> }:

let
  inherit (builtins)
    genList
    hashString
    match
    readFile
    substring
    ;
  inherit (lib)
    concatStrings
    fix
    flip
    mod
    pipe
    replicate
    ;

  last2 = "[0-9]*([0-9]{2})";

  seed = pipe /proc/stat [
    readFile
    (match ''
      .*
      intr ${last2}.*
      ctxt ${last2}.*
      softirq ${last2}.*'')
    concatStrings
  ];

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
