wipe_usb() {
  local dev="${1:-}"
  local fs="${2:-exfat}"
  local label="${3:-USB}"

  if [ -z "$dev" ]; then
    echo "Removable block devices:"
    lsblk -d -o NAME,SIZE,TYPE,TRAN,RM,MODEL | awk 'NR==1 || $5==1'
    printf "Device (e.g. sdb): "
    read dev
  fi

  dev="/dev/${dev#/dev/}"

  if [ ! -b "$dev" ]; then
    echo "Not a block device: $dev"
    return 1
  fi

  case "$dev" in
    /dev/nvme*|/dev/mmcblk*|/dev/sda)
      echo "Refusing to wipe $dev — looks like an internal disk."
      return 1
      ;;
  esac

  local rm_flag
  rm_flag="$(lsblk -dn -o RM "$dev" 2>/dev/null | tr -d ' ')"
  if [ "$rm_flag" != "1" ]; then
    echo "Refusing to wipe $dev — not marked removable."
    return 1
  fi

  echo
  lsblk "$dev"
  echo
  echo "This will DESTROY ALL DATA on $dev and format as $fs (label: $label)."
  printf "Type the device path to confirm (%s): " "$dev"
  read confirm
  if [ "$confirm" != "$dev" ]; then
    echo "Aborted."
    return 1
  fi

  sudo umount "${dev}"* 2>/dev/null
  sudo wipefs -a "$dev" || return 1
  printf 'g\nn\n\n\n\nw\n' | sudo fdisk "$dev" >/dev/null || return 1
  sudo partprobe "$dev" 2>/dev/null
  sleep 1

  local part="${dev}1"
  [ -b "$part" ] || part="${dev}p1"

  case "$fs" in
    exfat)      sudo mkfs.exfat -L "$label" "$part" ;;
    ext4)       sudo mkfs.ext4 -L "$label" "$part" ;;
    vfat|fat32) sudo mkfs.vfat -F32 -n "$label" "$part" ;;
    *) echo "Unknown fs: $fs (use exfat|ext4|vfat)"; return 1 ;;
  esac

  echo
  lsblk -f "$dev"
}
