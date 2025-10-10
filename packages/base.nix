{
  inputs,
  system,
  pkgs,
  flake,
  ...
}:
let

  module = {
    inherit pkgs;
    extraSpecialArgs = {
      modules = flake.modules.nixvim;
    };

    module = import ./base;
  };

  package = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule module;

in
package
// {
  passthru = package.passthru // {
    tests.check = inputs.nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule module;
  };
}
