throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
    # Zoom In: CTRL + =
    # Zoom Out CTRL + -
    # Show Sidebar: CTRL + B
    # Show Terminal: CTRL + J
    # Full Screen: F11
    # Zen Mode: Ctrl + K then Z
    # Fold All Regions: Ctrl+K Ctrl+0
    # Unfold All Regions: Ctrl+K Ctrl+J

#endregion


#lets take a look at the module cmdlets
Get-Command -module microsoft.powershell.secretmanagement

Get-Command -module microsoft.powershell.secretstore




#Build a vault
Register-SecretVault -Name VaultDemo -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault -AllowClobber

#view the vault
Get-SecretVault

#configure a vaul#change the default timeout value from 15 min to 30 min
Set-SecretStoreConfiguration -PasswordTimeout 1800

# default 900 seconds / 15 minutes

# Where is the vault password? Not required to build vault
# Why? because the vault is just an XML placeholder until a secret is stored within it.

#add a Secret
set-secret MyTextString -Secret "This is just some text"
Set-Secret MyAPIKey -Secret "c6854da1-743d-4234-bdd0-3f9832185b01"

# recall a secret
Get-Secret MyTextString

# save to a variable
$a = Get-Secret MyTextString

# add a PSCredential Object
Set-Secret -name CredMKAdmin -Secret (Get-credential)

#dont make this mistake (use a bad password)
Set-Secret CredDummyAdmin (Get-credential vagrant)

#attempt to connect with bad password
enter-pssession DC01 -credential (get-secret CredDummyAdmin)

$b = get-secret CredDummyAdmin
$b.Password | ConvertFrom-SecureString -AsPlainText


#setup MkAdmin variable
$MKAdmin = Get-Secret CredMKAdmin


# remove a secret
remove-secret MyAPIKey -Vault VaultDemo

Set-Secret MyAPIKey -Secret "c6854da1-743d-4234-bdd0-3f9832185b01"



# Where are those secrets stored on machine?
# C:\Users\username\AppData\Local\Microsoft\PowerShell\secretmanagement

# on my demo machine:
C:\Users\bsims\AppData\Local\Microsoft\PowerShell\secretmanagement



#create WinRM sessions
$SessionMKAdmin = new-pssession DC1 -Credential (Get-Secret -Name CredMKadmin -Vault VaultDemo)

#show hostname and whoami
hostname
whoami

$SessionVagrant = new-pssession DC1 -Credential (Get-Secret -Name CredVagrant -Vault VaultDemo)

#show hostname and whoami
hostname
whoami


# get AD info
get-aduser bsims -prop manager

get-aduser -filter "name -like 'aball*' "

#change AD info - add manager - denied
set-aduser bsims -Manager ABallard

#change AD info - add manager - alt creds
set-aduser bsims -Manager ABallard -Credential (get-secret CredMKAdmin)

set-aduser bsims -Manager $null -Credential (get-secret CredMKAdmin)

get-aduser bsims -prop manager

#set with variable
set-aduser bsims -Manager ACooke -Credential $Mkadmin

