{
  flake,
  inputs,
  system,
  pkgs,
  ...
}:
let

  module = {
    inherit pkgs;
    extraSpecialArgs = {
      inherit inputs system;
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
