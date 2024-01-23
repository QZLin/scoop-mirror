$scoop_home = Get-Item $env:USERPROFILE"/scoop/apps/scoop/current"
Push-Location $scoop_home

if (-not(Test-Path "lib/mirror.ps1")) {
    # Dev
    # Write-Output "Create Symblic Link of mirror.ps1"
    # New-Item -ItemType SymbolicLink -Path "lib/mirror.ps1" -Value (Get-Item $PSScriptRoot/mirror.ps1) 
}
Copy-Item $PSScriptRoot/mirror.ps1 "lib/mirror.ps1" -Force

$lib_install_ps1 = Get-Content lib/install.ps1
$result = $lib_install_ps1 -replace `
    "(?<!inject_url\()handle_special_urls \`$url", "inject_url(handle_special_urls `$url)"
Set-Content -Path lib/install.ps1 -Value $result
if (-not $lib_install_ps1.Contains(". `$PSScriptRoot/mirror.ps1")) {
    Write-Output (". `$PSScriptRoot/mirror.ps1") >> "lib/install.ps1"
}
Write-Output "Finished."
Pop-Location
