# annt's Templates for Nix

Collection of templates for Nix.

Contains both personal templates I have created myself, and templates I have
found useful from other sources. This is highly tailored to my own use cases,
but perhaps it is useful or inspiring to others as well.

## Usage

- Show all available templates:
```sh
nix flake show github:anntnzrb/nix-templates
```

- Use a template:
```sh
nix flake new -t github:anntnzrb/nix-templates#<template> <directory>

# e.g.
nix flake new -t github:anntnzrb/nix-templates#haskell some-haskell-project
```
