# Nix Flake for Neve

A pure functional language for system configuration and package management.

## Usage

### Try without installing

```bash
nix run github:MCB-SMART-BOY/nix-neve
```

### Install to profile

```bash
nix profile install github:MCB-SMART-BOY/nix-neve
```

### Use in flake.nix

```nix
{
  inputs.neve.url = "github:MCB-SMART-BOY/nix-neve";

  outputs = { self, nixpkgs, neve }:
    # ...
}
```

## More Info

- [GitHub Repository](https://github.com/MCB-SMART-BOY/Neve)
- [Documentation](https://github.com/MCB-SMART-BOY/Neve/tree/master/docs)
