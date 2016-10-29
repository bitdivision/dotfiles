#!/bin/bash
sudo -u bitdivision /usr/bin/notify-send "Starting Weekly Full Backup to Internal Drive"
date

#First check that the drive is mounted so we don't get any overlay mounts again
if /usr/bin/grep -qs '/media/BackupDrive' /proc/mounts; then

    /usr/bin/rsync -av --stats --log-file=/home/bitdivision/scripts/backups/full-backup-local.log /* /media/BackupDrive/backupFull --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/home/bitdivision/Downloads/*,/home/bitdivision/.cache/*,$HOME/.gvfs}

else
    echo "BackupDrive is not mounted. Not backing up to prevent overlay"
fi

sudo -u bitdivision /usr/bin/notify-send "Finished Weekly Full Backup to Internal Drive"

sudo -u bitdivision /usr/bin/notify-send "Starting Weekly Full Backup to NAS"

/usr/bin/nc -z Slingbox 22 || { echo "nobody home on port 22" >&2; sudo -u bitdivision notify-send "Couldn't connect to NAS on port 22"; exit; }
/usr/bin/ssh admin@Slingbox true || { echo "does not let me in" >&2; sudo -u bitdivision notify-send "Could not ssh into NAS even though box is up"; exit; }

/usr/bin/rsync -av --stats --delete --log-file=/home/bitdivision/scripts/backups/full-backup-NAS.log -e ssh /* admin@Slingbox:/volume1/Backup/backupFull --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/home/bitdivision/Downloads/*,/home/bitdivision/.cache/*,$HOME/.gvfs}
echo "Finished NAS weekly backup"
sudo -u bitdivision /usr/bin/notify-send "Finished Weekly Full Backup to NAS"
