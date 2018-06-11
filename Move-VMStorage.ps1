$TargetRoot = "D:\VM"

While ($true) {
    Clear 
    Get-VM | ForEach-Object { 
        Set-Variable -Name VmName -Value $_.Name
        Set-Variable -Name SourcePath -Value $_.Path
        Set-Variable -Name TargetPath -Value "$TargetRoot\$VmName"
        If ( $SourcePath -ne $TargetPath ) {
            If ( $_.OperationalStatus -eq 'OK' ) {
                Write-Host Moving $VmName from $SourcePath to $TargetPath
                Move-VMStorage -VMName $VmName -DestinationStoragePath $TargetPath
            } Else {
                Write-Host Unable tp move $VmName from $SourcePath to $TargetPath due to current operational status: $_.OperationalStatus
            }
        } Else {
            Write-Host $VmName is already in $TargetPath
        }
    }
    Sleep 60
}