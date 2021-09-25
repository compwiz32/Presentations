
# . "$psscriptroot\public\Get-PCInfo.ps1"
# . "$psscriptroot\public\Get-PCUpTime.ps1"
# . "$psscriptroot\Private\Get-DriveInfo.ps1"

# $pri = Get-ChildItem $pwd\public -filter *.PS1
# $pub = Get-ChildItem $pwd\private -Filter *.PS1

# $pub | ForEach-Object { . $_.Fullname }
# $pri | ForEach-Object { . $_.Fullname }

$root = Split-Path -Parent $MyInvocation.MyCommand.Definition
Get-ChildItem -Path $root\Public\*.ps1 | Foreach-Object { . $_.Fullname}
Get-ChildItem -Path $root\Private\*.ps1 | Foreach-Object { . $_.Fullname}