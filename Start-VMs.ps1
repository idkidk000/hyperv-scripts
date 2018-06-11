# Build an array of VM names, startup order and startup delay. Order and delay should be specified in the first line of the VM's notes field, e.g: "3,60" = third item, wait 60 seconds.
$VMArray=@()
# and $_.State -ne "Running"
Get-VM | Where-Object { $_.Notes -like "*,*,*" } | ForEach-Object {
    $VMStartupOrder = ( $_.Notes.Split(',') | Select-Object -First 1 )
    $VMStartupDelay = $( $_.Notes.Split(',') | Select-Object -Skip 1 -First 1 )
    $VMObject = New-Object psobject -Property @{ Name=$_.Name; StartupOrder=$VMStartupOrder -as [int]; StartupDelay=$VMStartupDelay -as [int] }
    $VMArray+=$VMObject
}

$VMArray | Sort-Object StartupOrder | FT StartupOrder, Name, StartupDelay


# Get the last item so that we know to ignore the delay
$LastVM = $( $VMArray | Sort StartupOrder | Select-Object -Last 1 )


$VMArray | Sort StartupOrder | ForEach-Object {
    If ( $(Get-VM -Name $_.Name).State -ne "Running" ) {
        Write-Host Starting VM $_.Name
        Start-VM -Name $_.Name
        If ( $_ -ne $LastVM) {    
            Write-Host Waiting $_.StartupDelay seconds
            Sleep $_.StartupDelay -Seconds
        } Else {
            Write-Host "Last VM - not waiting"
            # Don't wait if this is the last VM
        }
    } Else {
        Write-Host $_.Name is already running
    }
}