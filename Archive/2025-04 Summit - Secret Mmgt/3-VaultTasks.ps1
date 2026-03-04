throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J

#endregion

#clean the screen
cls

#region - lets take a look at the module cmdlets
Get-Command -module microsoft.powershell.secretmanagement

Get-Command -module microsoft.powershell.secretstore
#endregion

#view the vaults on my machine
Get-SecretVault
#endregion


#region - Setting up your first vault
#Build a vault
Register-SecretVault -Name DummyVault2 -ModuleName Microsoft.PowerShell.SecretStore -AllowClobber

#view the vault
Get-SecretVault
#endregion


#region - View vault configuration
Get-SecretStoreConfiguration

#change the default timeout value from 15 min to 30 min
Set-SecretStoreConfiguration -PasswordTimeout 1800

# default 900 seconds / 15 minutes
#endregion

#region - View new  configuration
Get-SecretStoreConfiguration

#region - secretmgmt tasks

# add some secrets
set-secret -Name DemoTextString -Secret "This is just some text" -Vault DummyVault2
Set-Secret -Name DemoAPIKey -Secret "c6854da1-743d-4234-bdd0-3f9832185b01" -Vault DummyVault2

#view a list of my secrets
Get-SecretInfo

# recall a secret
Get-Secret DemoTextString

# save to a variable
$a = Get-Secret DemoTextString
ConvertFrom-SecureString $a -AsPlainText

# save to a variable
$a = Get-Secret DemoTextString -AsPlainText
$a

# add a PSCredential Object (sample password on 1st tab)
Set-Secret -name DummyAdminCreds -Secret (Get-Credential)

#view the vault again
Get-SecretInfo

Get-Secret DummyAdminCreds
$b = (Get-Secret DummyAdminCreds)
ConvertFrom-SecureString $b.Password -AsPlainText


# remove a secret
remove-secret MyAPIKey -Vault SummitVault



#endregion
#END Demo 3

# --------------------------------
