# plugins/lsp.nix

{ configs, pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        package = pkgs.vimPlugins.nvim-lspconfig;
        servers = {
          cmake = { enable = true; };
          denols = { enable = false; };
          gopls = { enable = true; };
          bashls = { enable = true; };
          nil_ls = { enable = true; };
          html = { enable = true; };
          cssls = { enable = true; };
          ts_ls = { enable = true; };
          tblgen_lsp_server = {
            enable = true;
          }; # NOTE: see lsp_tblgn_compilation_db.lua
          tinymist = { enable = true; }; # typst
          zls = { enable = true; };
          ocamllsp = {
            enable = true;
            package = null;
            # package = pkgs.ocamlPackages.lsp;
          };
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings = {
              procMacro = { enable = true; };
              check = {
                command = "clippy";
                extraArgs = [ "--all-targets" ];
              };
              cargo = {
                extraEnv = {
                  CARGO_PATH = "~/.cargo/bin/cargo";
                  RUSTC_PATH = "~/.cargo/bin/rustc";
                };
              };
            };
          };
          clangd = {
            enable = true;
            cmd = [
              "clangd"
              "--background-index"
              "--background-index=false"
              "--limit-results=100"
              "--j=1"
              "--malloc-trim" # memory opt?
            ];
            extraOptions = {
              initializationOptions = {
                crossFileReferences = true;
                callHierarchy = true;
                compilationDatabaseDirectory = "build";
                fallbackFlags = [ "-std=c++17" ];
              };
            };
          };
          # python :D
          pyright = {
            enable = true;
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true;
                  diagnosticMode = "workspace";
                  useLibraryCodeForTypes = true;
                };
                pythonPath = "";
                venvPath = ".";
                venv = "venv";
              };
            };
          };
        };

        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
            "<leader>e" = "open_float";
          };
          lspBuf = {
            "gd" = "definition";
            "gi" = "implementation";
            "K" = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>ic" = "incoming_calls";
          };
        };
      };
      fidget.enable = true;
    };
  };
}

