$VM_NAME = "passthrough-test"

# 8800GT
# $instanceId = ( Get-PnpDevice | Where-Object { $_.Class -eq 'Display' -and $_.Status -eq 'Error'} ).InstanceId
# USB mass storage
$instanceId = ( Get-PnpDevice | Where-Object{ $_.Description -ilike 'USB Mass Storage*'} ).InstanceId


$deviceData = Get-PnpDeviceProperty DEVPKEY_Device_LocationPaths -InstanceId $instanceID
$locationPath = ( $deviceData ).data[0]

Write-Host instanceId is $instanceId
Write-Host deviceData is $deviceData | FT
Write-Host locationPath is $locationPath  Srio0

Write-Host Dismounting device
Dismount-VMHostAssignableDevice -LocationPath $locationPath -Force

Write-Host VM host assignable devices:
Get-VMHostAssignableDevice

Write-Host Setting $VM_NAME to turn off on host shutdown
Set-VM -Name $VM_NAME -AutomaticStopAction TurnOff

Write-Host Turning off $VM_NAME
Stop-VM -TurnOff -VMName $VM_NAME

Write-Host Adding PCIe device to $VM_NAME
Add-VMAssignableDevice -LocationPath $locationPath -VMName $VM_NAME

<#
Write-Host Starting $VM_NAME
#>