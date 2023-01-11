# Display progress message
Write-Output "Restarting Services"

# Restart COM+ service
Write-Progress -Activity "Restarting Services" -Status "Restarting COM+" -PercentComplete 10
Restart-Service -Name "EventSystem" -Force

# Restart Cryptographic service
Write-Progress -Activity "Restarting Services" -Status "Restarting Cryptographic" -PercentComplete 20
Restart-Service -Name "CryptSvc"

# Restart WMI service
Write-Progress -Activity "Restarting Services" -Status "Restarting WMI" -PercentComplete 40
Restart-Service -Name "Winmgmt" -Force

# Check if SQL Server VSS Writer service exists
$vssWriter = Get-Service -Name "SQLWriter" -ErrorAction SilentlyContinue
# If the service exists, restart it
if ($vssWriter -ne $null) {
  # Display progress message
  Write-Progress -Activity "Restarting Services" -Status "Restarting SQLWriter" -PercentComplete 50
  Restart-Service -Name "SQLWriter"
}

# Check if NTDS service exists
$vssWriter = Get-Service -Name "NTDS" -ErrorAction SilentlyContinue
# If the service exists, restart it
if ($vssWriter -ne $null) {
  # Display progress message
  Write-Progress -Activity "Restarting Services" -Status "Restarting Active Directory Domain Services" -PercentComplete 60
  Restart-Service -Name "NTDS" -Force
}

# Restart Volume Shadow Copy service
Write-Progress -Activity "Restarting Services" -Status "Restarting VSS" -PercentComplete 80
Restart-Service -Name "VSS"

# Get the "Backup Service Controller" service
$service = Get-Service -Name "Backup Service Controller" -ErrorAction SilentlyContinue
# Check if the service exists and is not running
if ($service -ne $null -and $service.Status -ne "Running") {
  Write-Progress -Activity "Restarting Services" -Status "Starting Backup Service Controller" -PercentComplete 90
  Restart-Service -Name "Backup Service Controller"
}

Write-Progress -Activity "Restarting Services" -Status "Completed" -PercentComplete 100
Write-Output "Completed"
