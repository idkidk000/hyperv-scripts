$MIN_RAM_GB = 4
$MIN_CORES = 4 #TODO
$hypervisors = ( get-vm | where-object { 
    $_.vmname -ilike '*esx*' -or
    $_.vmname -ilike '*vmware*' -or
    $_.vmname -ilike '*hyper*v*'
} ).vmname

get-vm | foreach-object {
    if ( $_.vmname -in $hypervisors ) {
        write-host $_.vmname IS a hypervisor -foregroundcolor green
        if ( 
            $_.state -notin 'saved', 'off'     `
            -and (
                -not ( get-vmprocessor -vmname $_.vmname ).exposevirtualizationextension `
            -or ( get-vmmemory -vmname $_.vmname ).dynamicmemoryenabled `
            -or ( get-vmmemory -vmname $_.vmname ).startup -lt ( $MIN_RAM_GB * 1024 * 1024 * 1024 ) `
            )
        ) {
            write-host '    stopping vm'
            stop-vm -vmname $_.vmname
        }
        if ( $_.state -eq 'saved' ) {
            write-host '    removing saved state'
            remove-vmsavedstate -vmname $_.vmname -erroraction silentlycontinue
        }
        if ( -not ( get-vmprocessor -vmname $_.vmname ).exposevirtualizationextensions ) {
            write-host '    enabling virtualization extensions'
            set-vmprocessor -vmname $_.vmname -exposevirtualizationextensions $true
        }

        # set-vmprocessor -vmname $_.vmname -cor
        if ( ( get-vmmemory -vmname $_.vmname ).dynamicmemoryenabled ) {
            write-host '    disabling dynamic memory'
            set-vmmemory -vmname $_.vmname -dynamicmemoryenabled $false
        }
        if ( ( get-vmnetworkadapter -vmname $_.vmname ).macaddressspoofing -eq 'off' ) {
            write-host '    enabling mac address spoofing'
            set-vmnetworkadapter -vmname $_.vmname -macaddressspoofing on
        }
        if ( ( get-vmmemory -vmname $_.vmname ).startup -lt ( $MIN_RAM_GB * 1024 * 1024 * 1024 ) ) {
            write-host '    increasing memory from '( ( get-vmmemory -vmname $_.vmname ).startup / 1024 / 1024 / 1024 )'GB to ' $MIN_RAM_GB' GB'           
            set-vmmemory -vmname $_.vmname -startupbytes ( $MIN_RAM_GB * 1024 * 1024 * 1024 )
        }
    } else {
        write-host $_.vmname IS NOT a hypervisor
        if ( $_.state -notin 'saved', 'off'     -and ( get-vmprocessor -vmname $_.vmname ).exposevirtualizationextensions ) {
            write-host '    stopping vm'
            stop-vm -vmname $_.vmname
        }
        if ( $_.state -eq 'saved' ) {
            write-host '    removing saved state'
            remove-vmsavedstate -vmname $_.vmname -erroraction silentlycontinue
        }
        if ( ( get-vmprocessor -vmname $_.vmname ).exposevirtualizationextensions ) {
            write-host '    disabling virtualization extensions'
            set-vmprocessor -vmname $_.vmname -exposevirtualizationextensions $false
        }
        if ( ( get-vmnetworkadapter -vmname $_.vmname ).macaddressspoofing -eq 'on' ) {
            write-host '    mac address spoofing is enabled. you may want to disable on this vm'
        }


    }
}