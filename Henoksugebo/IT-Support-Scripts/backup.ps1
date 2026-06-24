powershell
# Automated Backup Script
# Author: Henok Sugebo Joffe
# Description: Creates a daily backup of user data and system configuration files.

$source = "C:\Users\public\Documents"
$destination = "D:\Backups\DailyBackup"
$date = Get-Date -Format "yyyy-MM-dd"

$backupPath = "$destination\$date"
New-Item -ItemType Directory -Force $backupPath
copy-item -Path $source -Destination $backupPath -Recurse -Force

write-Output "Backup completed successfully on $date"
