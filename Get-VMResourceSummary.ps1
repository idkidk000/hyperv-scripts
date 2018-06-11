$ram=0
$cores=0
$space=0
$count=0
get-vm|where-object{$_.state -eq 'running'}|foreach-object{
    $ram+=$_.MemoryAssigned
    $cores+=( get-vmprocessor -vmname $_.name ).count
    $space+=$_.SizeOfSystemFiles
    $count++
}
write-host vm count: $count
write-host core count: $cores
write-host ram assigned: ($ram/1024/1024/1024) "gb"
write-host space consumed: ($space/1024/1024/1024) "gb"
