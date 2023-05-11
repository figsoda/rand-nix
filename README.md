# rand-nix

Eval-time random number generator for Nix without IFD

> **Note** Please don't use this

## Features

- 🔥 Blazingly slow
- 🙏 Perfectly uniform distributions if you believe in it
- 🚀 Impure, unreproducible, and indeterministic
- 🔒 Cryptographically insecure
- ⚡ Significantly more efficient than all known alternatives
- 💖 Made with love

## Usage

```console
$ nix repl . --extra-experimental-features "flakes repl-flake"
nix-repl> rng.int # random integer from [0, 2^32)
1133288953

nix-repl> map (rng: rng.intBetween 42 1000) (rng.take 8) # 8 random integers from [42, 1000)
[ 861 497 274 908 262 883 374 65 ]
```
