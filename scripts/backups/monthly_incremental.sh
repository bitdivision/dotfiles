#/bin/bash
PATH=/usr/bin:/bin:/usr/sbin:/sbin

export PATH


rsync --delete -avzub --exclude 'Downloads' --exclude 'VirtualBox VMs' /home/bitdivision/ /media/BackupDrive/Backups/Monthly




