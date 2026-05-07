#
# Treesitter language-injection overlay queries for Nix files.
#
# Reproduces the home-manager attrpath patterns that hmts.nvim used to provide
# (programs.bash.bashrcExtra → bash, programs.wezterm.extraConfig → lua, etc.)
# but using only built-in predicates, so the queries survive nvim upgrades and
# require no plugin code.
#
# Combine with the queries that nvim-treesitter ships, which already cover
# nixpkgs idioms (buildPhase, writeShellScript, runCommand, ...) and the
# `/* lang */ ''script''` comment annotation pattern.
#
_: {
  extraFiles."after/queries/nix/injections.scm".text = ''
    ;; extends

    ; Shebang detection in indented strings (e.g. starting with #!/usr/bin/env bash)
    ((indented_string_expression
       (string_fragment) @injection.language
       (#lua-match? @injection.language "^%s*#!"))
     @injection.content
     (#gsub! @injection.language ".*#!.*env (%S+).*" "%1")
     (#gsub! @injection.language ".*#!%s*%S*/(%S+).*" "%1")
     (#set! injection.include-children)
     (#set! injection.combined))

    ; programs.bash.{init,logout,profile,bashrc}Extra
    (binding
      attrpath: (attrpath
        (identifier) @_p1
        (identifier) @_p2
        (identifier) @_p3)
      expression: [
        (string_expression (string_fragment) @injection.content)
        (indented_string_expression (string_fragment) @injection.content)
      ]
      (#eq? @_p1 "programs")
      (#eq? @_p2 "bash")
      (#any-of? @_p3 "initExtra" "logoutExtra" "profileExtra" "bashrcExtra")
      (#set! injection.language "bash")
      (#set! injection.combined))

    ; programs.zsh.{completionInit,envExtra,initContent,initExtra,loginExtra,logoutExtra,profileExtra}
    (binding
      attrpath: (attrpath
        (identifier) @_p1
        (identifier) @_p2
        (identifier) @_p3)
      expression: [
        (string_expression (string_fragment) @injection.content)
        (indented_string_expression (string_fragment) @injection.content)
      ]
      (#eq? @_p1 "programs")
      (#eq? @_p2 "zsh")
      (#any-of? @_p3
        "completionInit" "envExtra" "initContent" "initExtra"
        "loginExtra" "logoutExtra" "profileExtra")
      (#set! injection.language "bash")
      (#set! injection.combined))

    ; programs.fish.{shellInit,interactiveShellInit,loginShellInit}
    (binding
      attrpath: (attrpath
        (identifier) @_p1
        (identifier) @_p2
        (identifier) @_p3)
      expression: [
        (string_expression (string_fragment) @injection.content)
        (indented_string_expression (string_fragment) @injection.content)
      ]
      (#eq? @_p1 "programs")
      (#eq? @_p2 "fish")
      (#any-of? @_p3 "shellInit" "interactiveShellInit" "loginShellInit")
      (#set! injection.language "fish")
      (#set! injection.combined))

    ; programs.wezterm.extraConfig → lua
    (binding
      attrpath: (attrpath
        (identifier) @_p1
        (identifier) @_p2
        (identifier) @_p3)
      expression: [
        (string_expression (string_fragment) @injection.content)
        (indented_string_expression (string_fragment) @injection.content)
      ]
      (#eq? @_p1 "programs")
      (#eq? @_p2 "wezterm")
      (#eq? @_p3 "extraConfig")
      (#set! injection.language "lua")
      (#set! injection.combined))

    ; programs.waybar.style → css
    (binding
      attrpath: (attrpath
        (identifier) @_p1
        (identifier) @_p2
        (identifier) @_p3)
      expression: [
        (string_expression (string_fragment) @injection.content)
        (indented_string_expression (string_fragment) @injection.content)
      ]
      (#eq? @_p1 "programs")
      (#eq? @_p2 "waybar")
      (#eq? @_p3 "style")
      (#set! injection.language "css")
      (#set! injection.combined))

    ; security.polkit.extraConfig → javascript
    (binding
      attrpath: (attrpath
        (identifier) @_p1
        (identifier) @_p2
        (identifier) @_p3)
      expression: [
        (string_expression (string_fragment) @injection.content)
        (indented_string_expression (string_fragment) @injection.content)
      ]
      (#eq? @_p1 "security")
      (#eq? @_p2 "polkit")
      (#eq? @_p3 "extraConfig")
      (#set! injection.language "javascript")
      (#set! injection.combined))

    ; programs.firefox.profiles.<profile>.userChrome → css
    (binding
      attrpath: (attrpath
        (identifier) @_p1
        (identifier) @_p2
        (identifier) @_p3
        (_) @_p4
        (identifier) @_p5)
      expression: [
        (string_expression (string_fragment) @injection.content)
        (indented_string_expression (string_fragment) @injection.content)
      ]
      (#eq? @_p1 "programs")
      (#eq? @_p2 "firefox")
      (#eq? @_p3 "profiles")
      (#eq? @_p5 "userChrome")
      (#set! injection.language "css")
      (#set! injection.combined))
  '';
}
