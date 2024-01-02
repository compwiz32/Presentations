throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J

#endregion

#Getting Started w AZ Keyvault


#region - build a vault in cloud - Azure Portal
# Note can also be done from cmd prompt

#endregion


#region - install AZKeyvault module on local machine
Install-Module Az.KeyVault

#endregion


#region - make a connection between secret mgmt and azkeyvault
$SubID = "8524f719-e282-4fbd-ac73-a55a151e5b71"
$VaultName = " fill in name "
Register-SecretVault -Module Az.KeyVault -Name AzKV -VaultParameters @{ AZKVaultName = $vaultName; SubscriptionId = $SubID}

#endregion


#region - Create a secret and store in AZKeyvault
set-secret CredAZDummyCred -secret (Get-Credential MK\DummyUser) -Vault $vaultName

#endregion


#region - view creds in the cloud
#browse to AZ portal in browser

#switch back to client01

#endregion


#region - view cloud creds from local ps cmd prompt
get-secretinfo

(get-secret CredAZDummyCred).password | ConvertFrom-SecureString

#endregion