# ps1_sysnative

# what until disk is attached.
$Timeout = 6000
$CheckEvery = 10
## Start the timer
$timer = [Diagnostics.Stopwatch]::StartNew()
## Keep in the loop while the computer is not pingable
while ((Get-Disk | where-object Serialnumber -ne "" | measure).count -eq 0)
{
    Write-Verbose -Message "Waiting for [$($ComputerName)] to become pingable..."
    ## If the timer has waited greater than or equal to the timeout, throw an exception exiting the loop
    if ($timer.Elapsed.TotalSeconds -ge $Timeout)
    {
       throw "Timeout exceeded. Giving up on ping availability to [$ComputerName]"
    }
    ## Stop the loop every $CheckEvery seconds
    Start-Sleep -Seconds $CheckEvery
}
 
## When finished, stop the timer
$timer.Stop()

# Find new openstack disk and initalize
get-disk | Where-Object SerialNumber -ne "" | Initialize-Disk

# add partition
get-disk | Where-Object SerialNumber -ne "" | New-Partition -UseMaximumSize -AssignDriveLetter

# remove readonly label
get-disk | Where-Object SerialNumber -ne "" | set-disk -isreadonly 0

# format with ntfs
get-disk | Where-Object SerialNumber -ne "" | get-partition | Where-Object Type -ne "Reserved" | Format-Volume -FileSystem NTFS -Confirm

