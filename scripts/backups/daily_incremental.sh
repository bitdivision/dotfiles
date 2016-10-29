B
#!/bin/bash
PATH=/usr/bin:/bin:/usr/sbin:/sbin
export PATH

#Find the day output e.g Mon, Tues, Wed etc.
path=`date | awk '{print $1}'`

#Execute the backup incrementally on top of the monthly.
rsync --delete -avzub --exclude 'Downloads' --exclude 'VirtualBox VMs' --link-dest=/media/BackupDrive/Backups/Monthly /home/bitdivision/ /media/BackupDrive/Backups/Dailies/$path

