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

# Where is the vault password? Not required to build vault
# Why? because the vault is just an XML placeholder until a secret is stored within it.

#add a Secret
set-secret TextString -Secret "This is just some text"
Set-Secret APIKey -Secret "c6854da1-743d-4234-bdd0-3f9832185b01"

#recall a secret
Get-Secret TextString

#save to a variable
$a = Get-Secret TextString


#add a PSCredential Object
Set-Secret -name CredMK -Secret (Get-credential)

#dont make this mistake
Set-Secret (Get-credential)

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
