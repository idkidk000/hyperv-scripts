Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -ilike '*print*' } | ForEach-Object { 
    Disable-WindowsOptionalFeature -FeatureName $_.FeatureName -Online -NoRestart 
}
