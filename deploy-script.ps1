#ps1

# what until disk is attached.

# wait unil disk with serialnumber is not equal 0
while ( (Get-Disk | where-object Serialnumber -ne "" | measure).count -eq 0 ) {
  Write-Host "Waiting 60 seconds to try again"
  Start-Sleep -s 60
}


# Find new openstack disk and initalize
get-disk | Where-Object SerialNumber -ne "" | Initialize-Disk

# add partition
get-disk | Where-Object SerialNumber -ne "" | New-Partition -UseMaximumSize -AssignDriveLetter

# remove readonly label
get-disk | Where-Object SerialNumber -ne "" | set-disk -isreadonly 0

# format with ntfs
get-disk | Where-Object SerialNumber -ne "" | get-partition | Where-Object Type -ne "Reserved" | Format-Volume -FileSystem NTFS -Confirm

