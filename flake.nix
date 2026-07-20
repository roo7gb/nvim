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
    packages.${system}.default =
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
                autocomplete.blink-cmp.enable = true;

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
                    base00 = "#151515";
                    base01 = "#161616";
                    base02 = "#242424";
                    base03 = "#5c5c5c";
                    base04 = "#6a6a6a";
                    base05 = "#b3aea2";
                    base06 = "#dadada";
                    base07 = "#4e4e4e";
                    base08 = "#d6717b";
                    base09 = "#d68571";
                    base0A = "#8c7094";
                    base0B = "#8ed671";
                    base0C = "#962b36";
                    base0D = "#6965a6";
                    base0E = "#d6b471";
                    base0F = "#29a6cc";
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
                    fg = "#5c5c5c";
                  };
                  SignColumn = {
                    bg = "NONE";
                    ctermbg = "NONE";
                  };
                  CursorLineNr = {
                    bg = "NONE";
                    ctermbg = "NONE";
                    fg = "#5c5c5c";
                  };
                };
              };
            }
          )
        ];
      }).neovim;
  };
}

