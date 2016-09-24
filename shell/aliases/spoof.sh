function spoof_mac_address {
  sudo ifconfig en1 ether `openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
}
