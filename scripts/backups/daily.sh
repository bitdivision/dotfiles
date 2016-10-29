#!/bin/bash

echo "Starting rsync backup to rsync.net"
sudo -u bitdivision /usr/bin/notify-send "Starting rsync backup to rsync.net"
date
/usr/bin/rsync -avz --delete --delete-excluded /home/bitdivision 15229@ch-s010.rsync.net:home-backup --exclude={Downloads/*,.cache/*,.sabnzbd.ini/Downloads/*,.gvfs,/Desktop,.VirtualBox/*,VirtualBox\ VMs/*}
echo "Finished rsync backup to rsync.net"
sudo -u bitdivision /usr/bin/notify-send "Finished rsync backup to rsync.net"

