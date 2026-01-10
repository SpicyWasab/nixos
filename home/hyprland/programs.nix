{ ... }:

{
  imports = map (name: ../programs/${name})[
    "alacritty.nix"
    "cavalier.nix"
  ];
}
