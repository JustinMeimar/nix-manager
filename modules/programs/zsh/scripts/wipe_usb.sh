wipe_usb() {
  local dev="${1:-}"
  local fs="${2:-vfat}"
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

  local max
  case "$fs" in
    exfat)      max=11 ;;
    ext4)       max=16 ;;
    vfat|fat32) max=11; label="${(U)label}" ;;
    *) echo "Unknown fs: $fs (use exfat|ext4|vfat)"; return 1 ;;
  esac
  if [ ${#label} -gt $max ]; then
    echo "Label '$label' is ${#label} chars, max $max for $fs. Truncating."
    label="${label:0:$max}"
  fi

  sudo umount "${dev}"* 2>/dev/null
  sudo wipefs -a "$dev" || return 1
  printf 'g\nn\n\n\n\nw\n' | sudo fdisk "$dev" >/dev/null || return 1
  sudo partprobe "$dev" 2>/dev/null
  sleep 1

  local part="${dev}1"
  [ -b "$part" ] || part="${dev}p1"

  sudo wipefs -a "$part" || return 1

  case "$fs" in
    exfat)      sudo mkfs.exfat -L "$label" "$part" || { echo "mkfs.exfat failed"; return 1; } ;;
    ext4)       sudo mkfs.ext4 -F -L "$label" "$part" || { echo "mkfs.ext4 failed"; return 1; } ;;
    vfat|fat32) sudo mkfs.vfat -F32 -n "$label" "$part" || { echo "mkfs.vfat failed"; return 1; } ;;
  esac

  echo
  lsblk -f "$dev"
}
