{
  paths = [
    ".rbenv/shims"
    ".rbenv/bin"
    ".npm-global/bin"
    ".bun/bin"
    ".pixi/bin"
    "install/cmake/bin"
    "CDOL/Tester/bin"
    "install/zig"
    "/usr/local/go/bin"
    "go/bin"
    ".deno/bin"
    "/home/linuxbrew/.linuxbrew/bin"
    ".local/bin"
    ".cargo/bin"
    "bin"
  ];
  aliases = {
    lsdir = "ls -d */";
    ll = "ls -la";
    gita = "git add";
    gitc = "git commit";
    gits = "git status";
    gitd = "git diff";
    gitds = "git diff --staged";
    gitl = "git log | bat";
    nv = "nvim .";
    t = "tmux";
    b = "z ..";
    b2 = "z ../..";
    b3 = "z ../../../";
    dog = "bat --style=plain --paging=never";
  };
}
