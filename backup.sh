#!/bin/bash

# DATABASE CONNECTION DETAILS
DBHOST=localhost
DBNAME=database
DBUSER=root
DBPASS=pass

# FTP SERVER DETAILS
FTPHOST=123.123.123.123
FTPUSER=username@domain.tld
FTPPASS=password
FTPFOLD=/home/

# MAKE FILE NAME
FileName=$(date +"%Y-%b-%d-%H:%M")_$DBNAME;

# GET BACKUP USING MYSQLDUMP COMMAND
mysqldump --single-transaction --user=$DBUSER --password=$DBPASS --host=$DBHOST $DBNAME > $FileName.sql

# TRANSFER BACKUP FILE TP FTP SERVER
ftp -n -v $FTPHOST << EOT
ascii
prompt
user $FTPUSER $FTPPASS
mput *_$DBNAME.sql $FTPFOLD
bye
EOT

# DELETE THE BACKUP FILE FROM LOCAL HOST
rm -rf *_$DBNAME.sql
