{ flake, perSystem, ... }:
perSystem.self.base.extend {
  imports = with flake.modules.nixvim; [
    vim-go
  ];
}
