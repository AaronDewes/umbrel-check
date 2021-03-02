#!/bin/bash

get_uas_string () {
  UDEVADM_DATA=$(sudo -u umbrel udevadm test /block/${block_device} 2> /dev/null)
  ID_VENDOR=$(echo "${UDEVADM_DATA}" | grep "ID_VENDOR_ID" | sed 's/ID_VENDOR_ID=//')
  ID_MODEL=$(echo "${UDEVADM_DATA}" | grep "ID_MODEL_ID" | sed 's/ID_MODEL_ID=//')
  echo "${ID_VENDOR}:${ID_MODEL}:u"
}

echo "Checking and recovering the file system"
sudo fsck /dev/sda -y

echo "Enabeling Umbrel again"
sudo systemctl enable umbrel-connection-details
sudo systemctl enable umbrel-startup
sudo systemctl enable umbrel-external-storage

echo "Rebooting in 5 seconds"
sleep 5
sudo reboot
