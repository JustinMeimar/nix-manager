{
  paths = [];
  aliases = {
      lsdir = "ls -d */";
      ll = "ls -la";
      # other git shortcuts come from oh-my-zsh git plugin.
      gs = "git status";
      gl = "git log | bat";
      gbr = "git branch";
      nv = "nvim .";
      t = "tmux";
      b = "z ..";
      b2 = "z ../..";
      b3 = "z ../../../";
      dog = "bat --style=plain --paging=never";
    };
}
