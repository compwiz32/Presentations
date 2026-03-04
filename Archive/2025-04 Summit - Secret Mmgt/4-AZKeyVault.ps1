throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J

#endregion

#Getting Started w AZ Keyvault


#region - build a vault in cloud - MK - Show AZKeyvault GUI Interface
# Note can also be done from cmd prompt

#endregion


#region - install AZKeyvault module on local machine
Install-Module Az.KeyVault -Scope AllUsers -Force

#endregion


#region - make a connection between secret mgmt and azkeyvault
$SubID = (Get-Secret -Name Tenant-Aligntech -AsPlainText)
$SMVaultName = "SummitAzKeyVault"
$AZVaultName = "zMKSummitTestVault"
$ResourceGrp = "prdaligniamrg"
New-AzKeyVault -Name $VaultName -ResourceGroupName $ResourceGrp -Location "EastUS"

Register-SecretVault -Module Az.KeyVault -Name 'SummitAZKeyVault' -VaultParameters @{ AZKVaultName = $AZVaultName}

Set-AzKeyVaultAccessPolicy -VaultName $AZVaultName -UserPrincipalName "mkanakos-admin@aligntech.com" -PermissionsToSecrets get, set, delete


#endregion


#region - Create a secret and store in AZKeyvault
set-secret CredAZDummyCred2 -secret (Get-Credential MK\DummyUser) -Vault "SummitAzKeyVault"

#set-secret CredAZMKAdmin1 -secret (Get-Credential Aligntech\mkanakos-admin) -Vault $SMVaultName

#let's look at what secrets exist in our vault
Get-SecretInfo

#endregion

#region - view creds in the cloud
#browse to AZ portal in browser

#endregion


#region - view cloud creds from local ps cmd prompt
get-secretinfo

(get-secret CredAZDummyCred2).password | ConvertFrom-SecureString

#endregion


#Login to that server from earlier using AzKeyVault
$svr = (Get-Secret SvrRDU-DC01 -AsPlainText)
Enter-PSSession $svr -Credential (Get-Secret TestCreds)

Exit-PSSession

#endregion


#region - End w Personal Anecdote / personal experiences
 # 2017 - meeting Mike and Jeff
 # 2018 - Presenter / book / blog / usergroup
 # 2019 - Summit org staff
 # 2020 - MVP