# Error Views

# v5
# normalview & categoryview

$errorview = "normalview"
[int]$number = Read-Host "what is the latest version of PowerShell ?"
break

$errorview = "categoryview"
break

$errorview = "normalview"
test-connection -ComputerName "notrealcomputer" -count 1
break

$errorview = "categoryview"
test-connection -ComputerName "notrealcomputer" -count 1

break


#v7
# normalview / conciseview / categoryview


$errorview = "normalview"
[int]$number = Read-Host "what is the latest version of PowerShell ?"

break

$errorview = 'conciseview'
[int]$number = Read-Host "what is the latest version of PowerShell ?"

break


#Get-Error cmdlet
Get-Childitem -path /NoRealDirectory

get-process | selct-object


#history of errors
Get-Error

get-error -newest 3

get-error -newest 20 | Out-GridView


Links:
https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-70?view=powershell-7

