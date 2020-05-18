#!/bin/sh
# Backup from MySQL database and send it to remote FTP storage
# Copyright (c) 2019 Nabi KAZ <www.nabi.ir> <nabikaz@gmail.com> <@NabiKAZ>
# This script is licensed under GNU GPL version 3.0 or above
# Firstly run:
#   chown +x /path/auto_backup_db.sh
# Usage in cronjobs:
#   0 3 root * * * /path/auto_backup_db.sh >/dev/null 2>&1
# ---------------------------------------------------------------------
DB_HOST=localhost
DB_PORT=3306
DB_USER=XXXXXXXXXXXXXXX
DB_PASS=XXXXXXXXXXXXXXX
DB_NAME=XXXXXXXXXXXXXXX
DB_FILE=database_${DB_NAME}_`date '+%Y-%m-%d_%H-%M-%S'`.sql.gz
FTP_HOST=XXXXXXXXXXXXXXX
FTP_PORT=21
FTP_USER=XXXXXXXXXXXXXXX
FTP_PASS=XXXXXXXXXXXXXXX
FTP_PATH=/
# ---------------------------------------------------------------------

#Create backup file
mysqldump -h $DB_HOST --port=$DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME | gzip > $DB_FILE

#Send backup file to remote FTP server
ncftpput -u "$FTP_USER" -p "$FTP_PASS" -P $FTP_PORT $FTP_HOST $FTP_PATH $DB_FILE

#Remove backup file
rm -f $DB_FILE
