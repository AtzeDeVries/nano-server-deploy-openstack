#ps1

# Find new openstack disk and initalize
get-disk | Where-Object SerialNumber -ne "" | Initialize-Disk

# add partition
get-disk | Where-Object SerialNumber -ne "" | New-Partition -UseMaximumSize -AssignDriveLetter

# remove readonly label
get-disk | Where-Object SerialNumber -ne "" | set-disk -isreadonly 0

# format with ntfs
get-disk | Where-Object SerialNumber -ne "" | get-partition | Where-Object Type -ne "Reserved" | Format-Volume -FileSystem NTFS -Confirm

# setup credentials to connect to ad
$password = ConvertTo-SecureString -asPlainText -Force ""
$username = ""
$ComputerName = ""

# join to the domain has to be done from the DC


