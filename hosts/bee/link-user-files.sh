# Run as justin by NixOS activation, never as root. All paths in the manifest
# are repository-controlled relative paths. Preflight the entire set first.
set -euo pipefail

user_home=$1
source_root=$2
manifest=$3
conflict=0

while IFS= read -r relative; do
  destination="$user_home/$relative"
  if [ -L "$destination" ]; then
    current=$(readlink "$destination")
    case "$current" in
      "$source_root/$relative"|/nix/store/*-home-manager-files/*) ;;
      *) printf 'Bee: move conflicting symlink aside: %s\n' "$destination" >&2; conflict=1 ;;
    esac
  elif [ -e "$destination" ]; then
    printf 'Bee: move conflicting file aside: %s\n' "$destination" >&2
    conflict=1
  fi
done < "$manifest"

if [ "$conflict" -ne 0 ]; then
  exit 1
fi

backup_root=""
while IFS= read -r relative; do
  destination="$user_home/$relative"
  if [ -L "$destination" ]; then
    current=$(readlink "$destination")
    if [ "$current" = "$source_root/$relative" ]; then
      continue
    fi
    if [ -z "$backup_root" ]; then
      mkdir -p "$user_home/.local/state/bee-nixos"
      backup_root=$(mktemp -d "$user_home/.local/state/bee-nixos/home-manager-links.XXXXXXXX")
      printf 'Bee: archiving old Home Manager links in %s\n' "$backup_root"
    fi
    mkdir -p "$backup_root/$(dirname "$relative")"
    # Dereference while the old Home Manager generation still exists, so the
    # backup survives garbage collection. Broken links are archived as links.
    if [ -e "$destination" ]; then
      cp -L "$destination" "$backup_root/$relative"
      unlink "$destination"
    else
      mv "$destination" "$backup_root/$relative"
    fi
  fi
  mkdir -p "$(dirname "$destination")"
  ln -s "$source_root/$relative" "$destination"
done < "$manifest"
