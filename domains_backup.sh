#!/bin/sh

# Variables
BACKUP_PATH="/srv/backups"
DOMAINS_PATH="/srv/www"

echo "Moving into ${DOMAINS_PATH}"
cd $DOMAINS_PATH

# ######### Web Site Backup #########
for i in $(find . -maxdepth 1 -mindepth 1 -type d -printf '%f\n'); do
  echo "Backing up $i ..."
  /usr/bin/zip -rq ${BACKUP_PATH}/$i\_`date "+%Y-%m-%d"`.zip ./$i/
done

# ######### Clean-up Old Junk #########
# Deleting backups older than 30 days
# echo "Removing old files"
/usr/bin/find ${BACKUP_PATH}/*.zip -mtime +30 -exec rm {} \;

