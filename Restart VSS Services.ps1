function Restart-ServiceWithProgress {
  param(
    [string]$serviceName,
    [int]$percentComplete,
    [string]$status,
    [bool]$force = $false
  )
  $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
  if ($null -ne $service) {
    Write-Progress -Activity "Restarting Services" -Status "Restarting $status" -PercentComplete $percentComplete
    Restart-Service -Name $serviceName -Force:$force
  } else {
    Write-Output "$serviceName is not found."
  }
}
# Display progress message
Write-Output "Restarting Services"
Restart-ServiceWithProgress -serviceName "EventSystem" -percentComplete 10 -status "COM+" -force:$true
Restart-ServiceWithProgress -serviceName "CryptSvc" -percentComplete 20 -status "Cryptographic"
Restart-ServiceWithProgress -serviceName "Winmgmt" -percentComplete 40 -status "WMI" -force:$true
Restart-ServiceWithProgress -serviceName "SQLWriter" -percentComplete 50 -status "SQLWriter"
Restart-ServiceWithProgress -serviceName "NTDS" -percentComplete 60 -status "Active Directory Domain Services" -force:$true
Restart-ServiceWithProgress -serviceName "VSS" -percentComplete 80 -status "VSS"
Restart-ServiceWithProgress -serviceName "Backup Service Controller" -percentComplete 90 -status "Starting Backup Service Controller"
Write-Progress -Activity "Restarting Services" -Status "Completed" -PercentComplete 100
Write-Output "Completed"