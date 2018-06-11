"ubuntu-server", "mageia", "devuan", "bodhi" | ForEach-Object {
    $vmname = "test-$_"
    New-VM `
        -Name $vmname `
        -MemoryStartupBytes ( 512 * 1024 * 1024 ) `
        -Generation 1 `
        -BootDevice CD `
        -NewVHDSizeBytes ( 16 * 1024 * 1024 * 1024 ) `
        -SwitchName "LAN Team" `
        -NewVHDPath "D:\VM\$vmname.vhdx" `
        -Force
        #-Path "D:\VM\$vmname" `
    Set-VMMemory `
        -VMName $vmname `
        -DynamicMemoryEnabled $true `
        -MinimumBytes ( 512 * 1024 * 1024 ) `
        -MaximumBytes ( 2 * 1024 * 1024 * 1024 )
    Set-VMProcessor `
        -VMName $vmname `
        -Count 2
    <#
    Set-VMDvdDrive `
        -VMName $vmname `
        -Path
    #>
    Move-VMStorage -VMName $vmname -DestinationStoragePath "D:\VM\$vmname"
}