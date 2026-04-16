{ pkgs ? import <nixpkgs> {} }:

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
  ];

  LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
  hardeningDisable = [ "all" ];

  shellHook = ''
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
