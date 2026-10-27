{
  config,
  lib,
  pkgs,
  ...
}:
let
  shell = import ../../modules/programs/zsh/settings.nix;
  scripts = (import ../../lib { }).concatDirFiles ../../modules/programs/zsh/scripts;
  sshHosts = import ../../modules/programs/ssh-hosts.nix { inherit lib; };
  sshConfig = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (
      name: host:
      let
        options = lib.filterAttrs (_: value: value != null) host;
        render = value: if builtins.isBool value then (if value then "yes" else "no") else toString value;
      in
      "Host ${name}\n"
      + lib.concatStringsSep "\n" (lib.mapAttrsToList (key: value: "  ${key} ${render value}") options)
      + "\n"
    ) sshHosts
  );
  gitConfig = lib.generators.toGitINI {
    user = {
      name = "justinmeimar";
      email = "meimar@ualberta.ca";
    };
    pull.rebase = true;
    init.defaultBranch = "main";
  };
  # These are user-specific files, with their contents owned by NixOS in /etc.
  # Empty zsh startup files retire Home Manager's session-vars/no_global_rcs.
  files = {
    ".zshenv" = "# Bee's shell environment is managed by NixOS.\n";
    ".zprofile" = "# See /etc/zprofile.\n";
    ".zshrc" = "# See /etc/zshrc; local additions go in ~/.zshrc.local.\n";
    ".config/git/config" = gitConfig;
    ".ssh/config" = sshConfig;
    ".vimrc" = ''
      set expandtab tabstop=4 shiftwidth=4 number
      set clipboard+=unnamedplus
      set autoindent smartindent
    '';
    ".config/tmux/tmux.conf" = "source-file /etc/tmux.conf\n";
    ".config/alacritty/alacritty.toml" =
      builtins.readFile ../../modules/programs/alacritty/alacritty.toml;
    ".config/zathura/zathurarc" = "set selection-clipboard clipboard\n";
  };
  sourceRoot = "/etc/nix-manager/justin";
  manifest = pkgs.writeText "bee-user-files" (
    lib.concatStringsSep "\n" (builtins.attrNames files) + "\n"
  );
  linkFiles = pkgs.writeShellApplication {
    name = "bee-link-user-files";
    runtimeInputs = [ pkgs.coreutils ];
    text = builtins.readFile ./link-user-files.sh;
  };
in
{
  imports = [ ../../modules/programs/nvim/nvim.nix ];

  users.users.justin.packages = lib.unique (
    (import ../../modules/packages/cli-packages.nix { inherit pkgs; })
    ++ (import ../../modules/packages/dev-packages.nix { inherit pkgs; })
    ++ (import ../../modules/packages/media-packages.nix { inherit pkgs; })
    ++ (with pkgs; [
      signal-cli
      qrencode
      zathura
      nixfmt
      libxml2
    ])
  );

  programs = {
    git.enable = true;
    vim.enable = true;
    nixvim.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      settings.global.hide_env_diff = true;
    };
    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
    zoxide.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = shell.aliases;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "z"
          "history"
        ];
        theme = "robbyrussell";
      };
      interactiveShellInit = lib.mkAfter ''
        if [[ $USER == justin ]]; then
          # Expand relative entries against HOME at shell startup.
          path=(
            ${lib.concatMapStringsSep "\n" (
              path: "\"${if lib.hasPrefix "/" path then path else "$HOME/${path}"}\""
            ) shell.paths}
            $path
          )
          typeset -U path
          export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border --tmux bottom,40%'
          export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap --color header:italic"
          ${builtins.readFile ../../modules/programs/zsh/zsh_env.sh}
          ${scripts}
        fi
      '';
    };
    tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 10000;
      keyMode = "vi";
      extraConfig = builtins.readFile ../../modules/programs/tmux/tmux.conf + ''
        set -g default-shell "${pkgs.zsh}/bin/zsh"
        set -g mouse on
        set -g @host-color brightgreen
        set -g @host-label bee
        bind-key r source-file /etc/tmux.conf \; display-message "tmux.conf reloaded."
      '';
    };
  };

  environment.etc = lib.mapAttrs' (
    relative: text: lib.nameValuePair "nix-manager/justin/${relative}" { inherit text; }
  ) files;

  # Run without root privileges. Only absent files and recognized Home Manager
  # symlinks are migrated; handwritten files cause a preflight failure.
  system.activationScripts.beeUserFiles = {
    deps = [
      "users"
      "etc"
    ];
    text = ''
      ${pkgs.util-linux}/bin/runuser -u justin -- \
        ${lib.getExe linkFiles} ${lib.escapeShellArg config.users.users.justin.home} \
        ${sourceRoot} ${manifest}
    '';
  };
}
