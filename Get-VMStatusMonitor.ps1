Write-Host Initializing. . .
$hostcores = ( ( get-wmiobject win32_processor ).numberoflogicalprocessors | measure-object -sum ).sum
$hostboottime = [Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem).LastBootUpTime)
$hostram = ( ( ( get-wmiobject win32_physicalmemory | where-object { $_.devicelocator -inotlike '*ROM*'} ).capacity | measure-object -sum ).sum /1024/1024/1024)
$hostname = ( get-silcomputer ).name
$hostmodel = ( get-silcomputer ).model
$hostcpumodel = ( get-silcomputer ).processorname
$hostcpucount = ( get-silcomputer ).numberofprocessors
$hostcpumhzmax = ( get-wmiobject win32_processor | select -First 1).maxclockspeed
$hostremotefxgpus = @()
$hostremotefxgpus += (Get-VMRemoteFXPhysicalVideoAdapter).Name

while ( $true ) { 
    $vmarray=@()
    $vmcorestotal = 0
    $vmramtotal = 0
    $vmcorestotalactive = 0
    $vmramtotalactive = 0
    get-vm | foreach-object {
        $vmcores = ( get-vmprocessor -vmname $_.name ).count
        $vmrambytes =  if ( $_.state -eq 'off' ) { $_.memorystartup } else { $_.memoryassigned }
        $vmram = $vmrambytes / 1024 / 1024 / 1024
        $vmuptime = ( new-timespan -days $_.uptime.days -hours $_.uptime.hours -minutes $_.uptime.minutes -seconds $_.uptime.seconds ).tostring('g')
        $vmremotefxcardcount=(Get-VMRemoteFx3dVideoAdapter -VMName $_.name | Measure-Object).Count
        $vmobject = new-object psobject -property @{
            Name=$_.Name
            Path=$_.Path
            State=$_.State
            Uptime=$vmuptime
            Cores=$vmcores

            RAM="{0:N1}GB" -f $vmram
            CPU="{0}%" -f ( $_.cpuusage/$vmcores*$hostcores )

            RemoteFXGPUs=$vmremotefxcardcount

            Status=$_.Status
        }
        $vmcores = ( get-vmprocessor -vmname $_.name ).count
        $vmarray+=$vmobject
        $vmcorestotal += $vmcores
        $vmramtotal += $vmram
        if ( $_.state -eq 'running' ) {
            $vmcorestotalactive += $vmcores
            $vmramtotalactive += $vmram
        }
    }


    $hostuptime = ( New-TimeSpan -Start $hostboottime -End ( Get-Date ) ).toString('g')
    $hostcpumhz = ( get-wmiobject win32_processor | select -First 1).currentclockspeed
    if ( ( get-wbjob ).jobstate -eq 'Running' ) {
        $hostbackup = ( get-wbjob ).currentoperation
    } Else {
        $prevbackupjob=get-wbjob -Previous 1
        $hostbackup="{0} at {1}" -f $prevbackupjob.jobstate, $prevbackupjob.endtime
    }
    $hostobject = new-object psobject -property @{
        Name=$hostname
        Model=$hostmodel
        CPUModel=$hostcpumodel
        CPUCount=$hostcpucount
        Cores="{0} ({1} Assigned, {2} Active)" -f $hostcores, $vmcorestotal, $vmcorestotalactive
        Clock="{0}Mhz ({1}Mhz Max)" -f $hostcpumhz, $hostcpumhzmax
        RAM="{0}GB ({1}GB Assigned, {2} Active)" -f $hostram, $vmramtotal, $vmramtotalactive
        # RemoteFXCGPUs=$hostremotefxgpus
        GPUs=$hostremotefxgpus
        BootTime=$hostboottime
        Uptime=$hostuptime
        BackupStatus=$hostbackup
    }

    clear
    ( $vmarray | format-table -autosize name, path, state, uptime, cores, ram, gpus, cpu, status | out-string ).trim()
    Write-Host "`nHost"
    Write-Host "-------------------------------------------------"
    ( $hostobject | format-list name, model, cpu, cpucount, cores, clock, ram, RemoteFXCGPUs, boottime, uptime, backupstatus | out-string ).trim()
    # get-volume | where-object { $_.driveletter.length -eq 1 -and $_.filesystemlabel -ne 'system reserved' -and $_.drivetype -eq 'fixed' } | ft -autosize
    # get-volume | where-object { $_.drivetype -ne 'cd-rom' } | ft -autosize driveletter, healthstatus, filesystemlabel, size, sizeremaining
    sleep 3
}



