throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J

#endregion

#MKNote - Continue Demo on Client02


#region - lets take a look at the module cmdlets
Get-Command -module microsoft.powershell.secretmanagement

Get-Command -module microsoft.powershell.secretstore
#endregion


#region - Setting up your first vault
#Build a vault
Register-SecretVault -Name VaultDemo -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault -AllowClobber

#view the vault
Get-SecretVault

# Where is the vault password? Not required to build vault
# Why? because the vault is just an XML placeholder until a secret is stored within it.
#endregion


#region - View vault configuration
Get-SecretStoreConfiguration

#change the default timeout value from 15 min to 30 min
Set-SecretStoreConfiguration -PasswordTimeout 1800

# default 900 seconds / 15 minutes
#endregion


#region - secretmgmt tasks

# add some secrets
set-secret MyTextString -Secret "This is just some text"
Set-Secret MyAPIKey -Secret "c6854da1-743d-4234-bdd0-3f9832185b01"

# recall a secret
Get-Secret MyTextString

# save to a variable
$a = Get-Secret MyTextString

# add a PSCredential Object
Set-Secret -name CredMKAdmin -Secret (Get-Credential)

# remove a secret
remove-secret MyAPIKey -Vault VaultDemo

Set-Secret MyAPIKey -Secret "c6854da1-743d-4234-bdd0-3f9832185b01"

#endregion



#region - bad data in / bad data out
Get-ADPrincipalGroupMembership DJacobs | Select-Object name

# dont make this mistake (use a bad password)
Set-Secret CredTypoExample (Get-credential mk\DJacobs)

#attempt to connect with bad password
enter-pssession DC01 -credential (get-secret CredTypoExample)

(get-secret CredTypoExample).password | ConvertFrom-SecureString -AsPlainText
#endregion


#region - still want to use a variable for creds?
#setup MkAdmin variable
$MKAdmin = Get-Secret CredMKAdmin
#endregion


#MKNote - Switch back to Client01 machine


#region - Where are those secrets stored on machine?
# C:\Users\username\AppData\Local\Microsoft\PowerShell\secretmanagement

# on my demo machine:
Invoke-Item C:\Users\bgoodman\AppData\Local\Microsoft\PowerShell\secretmanagement
#endregion


#region - use multiple secrets in code
# create WinRM sessions
new-pssession DC01 -Credential (Get-Secret -Name CredMKAdmin -Vault VaultDemo)
new-pssession Client02 -Credential (Get-Secret -Name CredMParker -Vault VaultDemo)
$S = Get-PSSession

Invoke-Command $S { Write-Output "$(whoami) on $(hostname)" }

#endregion


#region - change user creds on the fly!
# get AD info
get-aduser bsims -prop manager

#change AD info - add manager - denied
set-aduser bsims -Manager AStewart

#change AD info - add manager - alt creds
set-aduser bsims -Manager AStewart -Credential (get-secret CredMKAdmin)

set-aduser bsims -Manager $null -Credential (get-secret CredMKAdmin)

get-aduser bsims -prop manager

#endregion

#set with variable
set-aduser bsims -Manager ACooke -Credential $Mkadmin

