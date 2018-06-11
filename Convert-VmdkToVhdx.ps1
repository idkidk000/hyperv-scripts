Import-Module "C:\Program Files\Microsoft Virtual Machine Converter\MvmcCmdlet.psd1"
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\dc\dc.vmdk -DestinationLiteralPath E:\hyperv\dc.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\dc\dc_1.vmdk -DestinationLiteralPath E:\hyperv\dc_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\exch\exch.vmdk -DestinationLiteralPath E:\hyperv\exch.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\exch\exch_1.vmdk -DestinationLiteralPath E:\hyperv\exch_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\media\media.vmdk -DestinationLiteralPath E:\hyperv\media.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\media\media_1.vmdk -DestinationLiteralPath E:\hyperv\media_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\netman\netman.vmdk -DestinationLiteralPath E:\hyperv\netman.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\netman\netman_1.vmdk -DestinationLiteralPath E:\hyperv\netman_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\netman\netman_2.vmdk -DestinationLiteralPath E:\hyperv\netman_2.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\netman\netman_3.vmdk -DestinationLiteralPath E:\hyperv\netman_3.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\owncloud\owncloud_1.vmdk -DestinationLiteralPath E:\hyperv\owncloud_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\recode\recode.vmdk -DestinationLiteralPath E:\hyperv\recode.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\veeam\veeam.vmdk -DestinationLiteralPath E:\hyperv\veeam.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\veeam\veeam_1.vmdk -DestinationLiteralPath E:\hyperv\veeam_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\wds\wds_1.vmdk -DestinationLiteralPath E:\hyperv\wds_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath e:\vmware\web\web_1.vmdk -DestinationLiteralPath E:\hyperv\web_1.vhdx -VhdType FixedHardDisk -VhdFormat Vhdx
Write-Host "Complete!"