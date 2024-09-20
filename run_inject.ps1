param(
    [switch]$link = $false, 
    [switch]$dev = $false,
    [Parameter(Mandatory = $false)]
    $scoop_home = $null
)
if (-not $scoop_home) {
    $scoop_home = Get-Item $env:USERPROFILE"/scoop/apps/scoop/current"
}
Push-Location $scoop_home

# mirror
$lib_mirror = "lib/mirror.ps1"
if ($link) {
    if (Test-Path $lib_mirror) {
        Remove-Item -Path $lib_mirror
    }
    New-Item -ItemType SymbolicLink -Path $lib_mirror -Value (Get-Item "$PSScriptRoot/mirror.ps1") 
}
else {
    Copy-Item "$PSScriptRoot/mirror.ps1" $lib_mirror -Force
}


# inject
$patern = '(?<!inject_url\()handle_special_urls \$url', 'inject_url(handle_special_urls $url)'

if ($dev) {
    $lib_download = "lib/download.ps1"
    $lib_download_ps1 = Get-Content $lib_download
    $result = $lib_download_ps1 -replace '(?<!inject_url\()handle_special_urls \$url', 'inject_url(handle_special_urls $url)'
    Set-Content -Path $lib_download -Value $result

    if (-not $lib_download_ps1.Contains(". `$PSScriptRoot/mirror.ps1")) {
        Write-Output ('. $PSScriptRoot/mirror.ps1') >> $lib_download
    }
}
else {
    $lib_install = "lib/install.ps1"
    $lib_install_ps1 = Get-Content $lib_install
    $result = $lib_install_ps1 -replace $patern
    Set-Content -Path $lib_install -Value $result

    if (-not $lib_install_ps1.Contains(". `$PSScriptRoot/mirror.ps1")) {
        Write-Output (". `$PSScriptRoot/mirror.ps1") >> $lib_install
    }
}

Write-Output "Finished."
Pop-Location
