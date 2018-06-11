$id=0
get-vm | sort name | foreach-object { 
    set-vm -name $_.name -notes "$id,60,`nhere's somwe more stuff`nand more" -AutomaticStartAction nothing
    $id++
}
get-vm | ft name, notes
get-vm | select-object -first 1 | fl name, notes