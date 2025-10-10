{ modules, ... }:
{
  imports = [
    modules.base
    ./autocommands.nix
    ./completion.nix
    ./keymappings.nix
    ./options.nix
    ./performance.nix
  ];
}
