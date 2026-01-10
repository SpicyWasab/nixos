{ ... }:

{
  imports = map (name: ../programs/${name})[
    "cavalier.nix"
  ];
}
