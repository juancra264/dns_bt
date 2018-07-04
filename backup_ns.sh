#!/bin/bash
# Daily backup script crontab config as root
# 57 18 * * * /root/backup_ns.sh 

# Create some needed variable
bind_path="/etc/bind/"
base_path="/root/bind_backup/"
base_file="/root/bind_backup/bind_"
filename="$base_file$(date +%Y%m%d%H%M).tar.gz"

# Backup Server Configuration
tar -zcpf $filename $bind_path

# Remove backup files older than 30 days
find $base_path -name *.tar.gz -type f -mtime +7 -exec rm {} \;

# Copy the backups to another server (sFTP BT LATAM) 10.57.23.24 user jcramirez
scp -i /home/jcramirez/.ssh/id_rsa /root/bind_backup/* jcramirez@ftp.btlatam.com.co:/home/jcramirez/bind_backup
