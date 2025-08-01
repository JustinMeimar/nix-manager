# plugins/lsp.nix

{ configs, pkgs, ...}:
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true; 
        package = pkgs.vimPlugins.nvim-lspconfig;
        servers = {
            
          # one-liners
          cmake = { enable = true; };   # cmake
          denols = { enable = false; }; # deno 2
          gopls = { enable = true; };   # go
          bashls = { enable = true; };  # bash
          nil_ls = { enable = true; };  # nix
          html = { enable = true; };    # html
          cssls =  { enable = true; };  # css
          ts_ls = { enable = true; };   # typescript 
          tblgen_lsp_server = { enable = true; }; # NOTE: see lsp_tblgn_compilation_db.lua
          tinymist = { enable = true; }; # typst (why not named typst_lsp pls...)
          zls = { enable = true; };

          # rust!
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings = {
              procMacro = {
                enable = true;
              };
              check = {
                command = "clippy";
                extraArgs = ["--all-targets"];
              };
              cargo = {
                extraEnv = {
                  CARGO_PATH = "~/.cargo/bin/cargo";
                  RUSTC_PATH = "~/.cargo/bin/rustc";
                };
              };
            };
          };

          # c/c++
          clangd = {
            enable = true;
            extraOptions = {
              initializationOptions = {
                crossFileReferences = true;
                callHierarchy = true;
                compilationDatabaseDirectory = "build";
                fallbackFlags = [
                  "-std=c++17"
                ];
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
    
    # Configure diagnostics to only show in sign column
    # extraConfigLua = ''
    #   vim.diagnostic.config({
    #     virtual_text = false,
    #     signs = true
    #     underline = true
    #     update_in_insert = false,
    #     severity_sort = true,
    #     float = {
    #       border = 'rounded',
    #       source = 'always',
    #     },
    #   })
    # '';
  };
}

