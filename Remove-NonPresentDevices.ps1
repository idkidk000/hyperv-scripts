#Write-Host "NATIVE PS"
$WmiDevices = Get-WmiObject -Class Win32_PnpSignedDriver 
Get-PnpDevice | Where-Object { $_.Present -eq $False -or $_.Status -eq 'Unknown' } | Sort DeviceID | Select -First 3 | ForEach-Object { 
	Write-Host "================================================"
    
    Write-Host -ForegroundColor Yellow Device ID:   $_.DeviceID
    Write-Host -ForegroundColor Yellow Description: $_.Description
    $_ | Get-PnpDeviceProperty | FT -AutoSize

    # WMI doesn't show non-present devices. Useless fuck.
    # $deviceId=$_.DeviceID
    # Write-Host -ForegroundColor Yellow Device ID: $deviceId""
    # $WmiDevices | Where-Object { $_.DeviceID -like "*$deviceId*" }
    # Write-Host DeviceID: $_.DeviceID
    # Write-Host Full Device: $_
    # Write-Host Filter: "DeviceID='$($_.DeviceID)'"
	# Get-WmiObject -Class Win32_PnpSignedDriver-Filter: "DeviceID='$($_.DeviceID)'"

}



#Write-Host "WMI"
#Get-WmiObject -Class Win32_PnpSignedDriver  | Where-Object { $_.DeviceID -ilike '*VEN_8086*' } | FT DeviceID, Description

