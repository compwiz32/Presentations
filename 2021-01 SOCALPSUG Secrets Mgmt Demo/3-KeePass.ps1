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

# Download and Install KeePass
https://keepass.info/download.html

# Create a KeePass database with a master password
Database Name: mktest

# Do this inside the app

# Secret Mgmt - KeePass
https://www.powershellgallery.com/packages/SecretManagement.KeePass/0.0.4.4

#install Module
Install-Module SecretManagement.KeePass

# Register Vault
Register-SecretVault -Name 'mktest' -ModuleName 'SecretManagement.Keepass' -VaultParameters @{
    Path = "c:\keepass\database.kdbx"
    UseMasterPassword = $true
}

# create a secret inside the windows app



#read secret from vault
Get-Secret -Name "KeePassVagrant" -vault "testvault"

$SessionKeePass = new-pssession DC1 -Credential (Get-Secret -Name KeePassVagrant -Vault testvault)