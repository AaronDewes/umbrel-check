#!/bin/bash

echo "Preparing your node"
echo "-------------------"

sudo systemctl disable umbrel-connection-details
sudo systemctl disable umbrel-startup
sudo systemctl disable umbrel-external-storage

echo "Checking for UAS issues"
if [[ $(dmesg | grep --quiet "uas_abort_handler") > 0 ]]; then
  echo "External storage might have UAS issues"
  UAS_STRING=$(get_uas_string)
  if [[ $(cat /boot/cmdline.txt | grep --quiet "${UAS_STRING}") == 0 ]]; then
    sed "s/usb-storage.quirks=/usb-storage.quirks=$(get_uas_string),/g" -i /boot/cmdline.txt
    echo "Rebooting"
    sudo reboot
  fi
else
echo "No UAS issue detected"
fi

echo "Rebooting in 5 seconds"
sleep 5
sudo reboot
