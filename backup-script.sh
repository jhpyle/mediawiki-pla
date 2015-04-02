#! /bin/sh

TIMESTAMP=$(date +%u)
BACKUP_DIR="/root/mysqlbackup/$TIMESTAMP"
MYSQL_USER="root"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="xxxsecretxxx"
MYSQLDUMP=/usr/bin/mysqldump

# Create a local backup directory for the dump of the MySQL databases, if this directory does not already exist
mkdir -p $BACKUP_DIR

# get a list of databases in the MySQL store
databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
 
# backup each database into a folder numbered according to the day of the week it is; i.e., this is a rolling backup that gets overwritten each week
for db in $databases; do
  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$db.gz"
done

# mount a Windows network drive for storing the backups
mount -v -t cifs -o rw,uid=1000,username=jpyle,noperm,password=xxxsecret,ip=192.168.200.23 //newsnap/D /mnt

backupdir="/mnt/users/JPyle/Do not delete/wiki-backup"
# exit with an error if the mounting of the network drive did not work
if [ ! -d "$backupdir" ]; then
  echo "Backup directory $backupdir does not exist!"
  umount /mnt
  exit 0
fi
# create the external backup directory for the wiki files
mkdir -p "$backupdir/var/lib/mediawiki-intake"
# create the external backup directory for the MySQL database dump
mkdir -p "$backupdir/root/mysqlbackup"
# copy the wiki files (includes PHP code, extensions, and uploaded files)
rsync -au --copy-links --copy-links /var/lib/mediawiki-intake/ "$backupdir/var/lib/mediawiki-intake/"
# copy the database dumps
rsync -au --copy-links --copy-links /root/mysqlbackup/ "$backupdir/root/mysqlbackup/"
# unmount the Windows network drive
umount /mnt
