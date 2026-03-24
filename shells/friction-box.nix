{ pkgs ? import <nixpkgs> {} }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "34" "35" ];
    buildToolsVersions = [ "34.0.0" "35.0.0" ];
    includeEmulator = true;
    includeSources = false;
    includeSystemImages = true;
    systemImageTypes = [ "google_apis" ];
    abiVersions = [ "x86_64" ];
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

  GIT_AUTHOR_NAME = "justinvidual";
  GIT_COMMITTER_NAME = "justinvidual";
  GIT_AUTHOR_EMAIL = "justin.vidual@gmail.com";
  GIT_COMMITTER_EMAIL = "justin.vidual@gmail.com";
  GIT_CONFIG_COUNT = "1";
  GIT_CONFIG_KEY_0 = "url.git@github-vidual:.insteadOf";
  GIT_CONFIG_VALUE_0 = "git@github.com:";
  GH_CONFIG_DIR = "$HOME/.config/gh-vidual";

  shellHook = ''
    echo "friction-box development environment loaded"
    echo "  git:     $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
    echo "  bun:     $(bun --version)"
    echo "  node:    $(node --version)"
    echo "  just:    $(just --version)"
    echo "  java:    $(java --version 2>&1 | head -1)"
    echo "  gradle:  $(gradle --version 2>/dev/null | grep 'Gradle' | head -1)"
    echo "  android: $ANDROID_HOME"
  '';
}
