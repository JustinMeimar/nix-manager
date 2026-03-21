{ pkgs ? import <nixpkgs> {} }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "34" "35" ];
    buildToolsVersions = [ "34.0.0" "35.0.0" ];
    includeEmulator = false;
    includeSources = false;
    includeSystemImages = false;
    includeNDK = false;
  };
  androidSdk = androidComposition.androidsdk;
in
pkgs.mkShell {
  name = "friction-box-dev";

  buildInputs = with pkgs; [
    bun
    nodejs
    just
    jdk21
    gradle
    androidSdk
  ];

  ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
  ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
  JAVA_HOME = "${pkgs.jdk21}";

  shellHook = ''
    echo "friction-box development environment loaded"
    echo "  bun:     $(bun --version)"
    echo "  node:    $(node --version)"
    echo "  just:    $(just --version)"
    echo "  java:    $(java --version 2>&1 | head -1)"
    echo "  gradle:  $(gradle --version 2>/dev/null | grep 'Gradle' | head -1)"
    echo "  android: $ANDROID_HOME"
  '';
}
