$CONVERTER_PATH='C:\Program Files (x86)\StarWind Software\StarWind V2V Image Converter\StarV2Vc.exe'
$OUTPUT_PATH='D:\VMDK'

Import-Module "C:\Program Files\Microsoft Virtual Machine Converter\MvmcCmdlet.psd1"

Get-VM | Where-Object {$_.name -inotlike 'test-*'} | Select -First 1 | ForEach-Object {
    $disk_no=0
    Get-VMHardDiskDrive -VMName $_.VMName | ForEach-Object {
        $vm_name=$_.VMName
        $in_file='"'+$_.Path+'"'
        $out_file='"'+"$OUTPUT_PATH\$vm_name-$disk_no.vmdk"+'"'
        # $command="$CONVERTER_PATH if=$in_file ot=VMDK_S of=$out_file vmdktype=scsi"
        # $command
        # & $command
        $params="if=$in_file ot=VMDK_S of=$out_file vmdktype=scsi"
        "$CONVERTER_PATH $params"
        & $CONVERTER_PATH $params
        $disk_no++
    }
}


