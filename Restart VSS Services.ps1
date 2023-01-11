function Restart-ServiceWithProgress {
  param(
    [string]$Name,
    [int]$PercentComplete,
    [string]$Status,
    [bool]$Force
  )
  if($null -ne (Get-Service -Name $Name -ErrorAction SilentlyContinue)) {
    Write-Progress -Activity "Restarting Services" -Status "Restarting $Status" -PercentComplete $PercentComplete
    Restart-Service -Name $Name -Force:$Force
  } else {
    Write-Output "$Name is not found."
  }
}

$services = @(
  @{Name = "EventSystem";PercentComplete = 10;Status = "COM+";Force = $true},
  @{Name = "CryptSvc";PercentComplete = 20;Status = "Cryptographic";Force = $false},
  @{Name = "Winmgmt";PercentComplete = 40;Status = "WMI";Force = $true},
  @{Name = "SQLWriter";PercentComplete = 50;Status = "SQLWriter";Force = $false},
  @{Name = "NTDS";PercentComplete = 60;Status = "Active Directory Domain Services";Force = $true},
  @{Name = "VSS";PercentComplete = 80;Status = "VSS";Force = $false},
  @{Name = "Backup Service Controller";PercentComplete = 90;Status = "Starting Backup Service Controller";Force = $false}
)

# Display progress message
Write-Output "Restarting Services"

foreach($service in $services){
  Restart-ServiceWithProgress @service
}
Write-Progress -Activity "Restarting Services" -Status "Completed" -PercentComplete 100
Write-Output "Completed"