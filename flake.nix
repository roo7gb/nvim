# neovim flake

{
  description = "roo7gb neovim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }: let

    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.gb-nvim =
      (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          (
            { pkgs, ... }: {

              config.vim = {
                viAlias = false;
                vimAlias = false;
                options = {
                  tabstop = 2;
                  shiftwidth = 2;
                };

                statusline.lualine.enable = true;
                autocomplete.blink_cmp.enable = true;

                telescope = {
                  enable = true;

                  extensions = [
                    {
                      name = "fzf";
                      packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
                      setup = { fzf = { fuzzy = true; }; };
                    }
                  ];
                };

                lsp = {
                  enable = true;
                  lspkind.enable = true;
                };
                languages = {
                  enableTreesitter = true;
                  enableFormat = true;

                  clang.enable = true;
                  cmake.enable = true;
                  css.enable = true;
                  docker.enable = true;
                  go.enable = true;
                  html.enable = true;
                  json.enable = true;
                  lua.enable = true;
                  make.enable = true;
                  markdown.enable = true;
                  nix = {
                    enable = true;
                    lsp.servers = [ "nixd" ];
                  };
                  python.enable = true;
                  toml.enable = true;
                  typescript.enable = true;
                  xml.enable = true;
                  yaml.enable = true;
                  zig.enable = true;
                };

                theme = {
                  enable = true;
                  name = "base16";
                  transparent = true;

                  base16-colors = {
                    base00 = "#161616";
                    base01 = "#d6717b";
                    base02 = "#8ed671";
                    base03 = "#d6b471";
                    base04 = "#3395b2";
                    base05 = "#8c7094";
                    base06 = "#6965a6";
                    base07 = "#dadada";
                    base08 = "#606060";
                    base09 = "#d6404f";
                    base0A = "#72d64b";
                    base0B = "#d6a84b";
                    base0C = "#29a6cc";
                    base0D = "#896094";
                    base0E = "#5f59b3";
                    base0F = "#f8f8f8";
                  };
                };

                highlight = {
                  Normal = {
                    bg = "NONE";
                    ctermbg = "NONE";
                  };
                  NormalNC = {
                    bg = "NONE";
                    ctermbg = "NONE";
                  };
                  LineNr = {
                    bg = "NONE";
                    ctermbg = "NONE";
                  };
                  SignColumn = {
                    bg = "NONE";
                    ctermbg = "NONE";
                  };
                  CursorLineNr = {
                    bg = "NONE";
                    ctermbg = "NONE";
                  };
                };
              };
            }
          )
        ];
      }).neovim;
  };
}

