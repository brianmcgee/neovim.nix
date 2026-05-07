{ flake, perSystem, ... }:
flake.lib.mkNvim {
  base = perSystem.self.default;
  modules = [ flake.modules.nixvim.go ];
}
