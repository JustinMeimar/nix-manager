{ pkgs ? import <nixpkgs> {} }:

let
  rr-master = pkgs.rr.overrideAttrs (old: {
    version = "unstable-2026-05-13";
    src = pkgs.fetchFromGitHub {
      owner = "rr-debugger";
      repo = "rr";
      rev = "b835bbdee5bed59094f76e1f29437e6043254f8e";
      sha256 = "1fchzakpb1yrb36fpr3afgvhn2ba6949np2wnkbq7fik8j0apada";
    };
    patches = [];
  });
in

pkgs.mkShell {
  name = "spidermonkey-dev";
  buildInputs = with pkgs; [
    python3
    python3Packages.pip
    rustc
    cargo
    rust-analyzer
    clang
    llvm
    llvmPackages.bintools
    autoconf
    m4
    yasm
    nodejs
    pkg-config
    sccache
    gnumake
    ninja
    gdb
    just
    zlib
    libffi
    which
    perl
    git
    rust-cbindgen
    bear
    uv

    alsa-lib
    libpulseaudio
    gtk3
    glib
    dbus
    dbus-glib
    pango
    atk
    at-spi2-atk
    gdk-pixbuf
    cairo
    freetype
    fontconfig
    libdrm
    mesa
    pipewire
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxrender
    libxt
    libxtst
    libxcb
    libice
    libsm
    nasm
    libxkbcommon
    adwaita-icon-theme
    gsettings-desktop-schemas
    dconf
    libcanberra-gtk3
    libclang.lib
    udev
    mitmproxy
    rr-master
  ];

  LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
  hardeningDisable = [ "all" ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath (with pkgs; [
      stdenv.cc.cc.lib
      zlib
      gtk3
      glib
      pango
      cairo
      gdk-pixbuf
      atk
      at-spi2-atk
      at-spi2-core
      dbus
      dbus-glib
      fontconfig
      freetype
      libpulseaudio
      alsa-lib
      pipewire
      libx11
      libxcb
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxrender
      libxtst
      libxt
      libxkbcommon
      libice
      libsm
      libdrm
      mesa
      libcanberra-gtk3
      udev
    ])}:$LD_LIBRARY_PATH"
    export XDG_DATA_DIRS="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.adwaita-icon-theme}/share:$XDG_DATA_DIRS"
    export GIO_EXTRA_MODULES="${pkgs.dconf.lib}/lib/gio/modules"
    export GTK_PATH="${pkgs.libcanberra-gtk3}/lib/gtk-3.0"
    export MOZ_ENABLE_WAYLAND=''${MOZ_ENABLE_WAYLAND:-1}

    echo "SpiderMonkey development environment loaded"
    echo "  - python:          $(python3 --version)"
    echo "  - rustc:           $(rustc --version)"
    echo "  - cargo:           $(cargo --version)"
    echo "  - clang:           $(clang --version | head -n1)"
    echo "  - node:            $(node --version)"
    echo "  - just:            $(just --version)"
    echo "  - sccache:         $(sccache --version)"
    echo ""
  '';
}
