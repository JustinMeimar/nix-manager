# plugins/lsp.nix
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
	  
	  # TODO: Figure out include files
          clangd = {
            enable = true;
            extraOptions = {
              initializationOptions = {
                compilationDatabaseDirectory = "build";
		fallbackFlags = [
		  "-std=c++17"
		  "-I/home/justin/install/llvm/llvm-18/include/"
		];
              };
            };
          };

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
              };
            };
          };
        };

        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
          lspBuf = {
            "gd" = "definition";
            "gr" = "references";
            "K" = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
        };
      };

      lsp-lines.enable = true;
      fidget.enable = true;
    };
  };
}

