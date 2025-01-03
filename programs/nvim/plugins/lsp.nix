# plugins/lsp.nix
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true; 
	servers = {
	  
	  # html
	  html = {
	    enable = true;
	  };
	  
	  # css
	  cssls =  {
	    enable = true;
	  };
	  
	  # type/java script
	  ts_ls = {
            enable = false;
          };
	
	  # deno 2
	  denols = {
	    enable = true;
	  };
	  
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
	    # TODO: Figure out include files
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

