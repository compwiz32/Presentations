throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J

#endregion

#region - WinRM Demo
# intro what remoting is - secure session from cmd line

cd c:\
cls

# Demo remoting with no credential to DC (this will fail)
Enter-PSSession DC01

# passwords in PowerShell the old way (use a bogus password)!
$DummyCreds = Get-credential mk\MkAdmin
$OldSchoolCreds = Get-credential mk\MkAdmin

# connect to DC as admin with oldschoolcreds
enter-pssession DC01 -Credential $OldSchoolCreds
Write-Output "$(whoami) on $(hostname)"

Exit-PSSession

#endregion


#region - Extract that password!!!
clear
$DummyCreds.Password | ConvertFrom-SecureString -AsPlainText

#endregion


#region - Demo Secret Mgmt real world use case
enter-pssession DC01 -Credential (get-secret credmkadmin)
Write-Host "$(whoami) on $(hostname)"

#endregion