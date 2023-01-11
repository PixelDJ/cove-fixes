function Restart-ServiceWithProgress {
  param(
    [string]$Name,
    [int]$PercentComplete,
    [string]$FriendlyName,
    [bool]$Force
  )
  if($null -ne (Get-Service -Name $Name -ErrorAction SilentlyContinue)) {
    Write-Progress -Activity "Restarting Services" -Status "Restarting $FriendlyName" -PercentComplete $PercentComplete
    Restart-Service -Name $Name -Force:$Force
  } else {
    Write-Output "$Name is not found."
  }
}

$services = @(
  @{Name = "EventSystem";PercentComplete = 10;FriendlyName = "COM+";Force = $true},
  @{Name = "CryptSvc";PercentComplete = 20;FriendlyName = "Cryptographic";Force = $false},
  @{Name = "Winmgmt";PercentComplete = 40;FriendlyName = "WMI";Force = $true},
  @{Name = "SQLWriter";PercentComplete = 50;FriendlyName = "SQLWriter";Force = $false},
  @{Name = "NTDS";PercentComplete = 60;FriendlyName = "Active Directory Domain Services";Force = $true},
  @{Name = "VSS";PercentComplete = 80;FriendlyName = "VSS";Force = $false},
  @{Name = "Backup Service Controller";PercentComplete = 90;FriendlyName = "Backup Service Controller";Force = $false}
)

Write-Output "Restarting Services"

foreach($service in $services){
  Restart-ServiceWithProgress @service
}

Write-Progress -Activity "Restarting Services" -Status "Completed" -PercentComplete 100
Write-Output "Completed"