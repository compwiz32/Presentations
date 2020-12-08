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



#region - set your demo folders
$DemoRoot =
$DemoModuleSimple =
$DemoModuleWithManifest =
$DemoModulePublicPrivate =
$UserModuleFolder =

#endregion

# doc Link
https://devblogs.microsoft.com/powershell/secretmanagement-preview-6-and-secretstore-preview-4/

#passwords in PowerShell the old way!
$oldcred = Get-credential mklab\mkana

# Extract the password - insecure
$oldcred.Password | ConvertFrom-SecureString -AsPlainText

# a better way - secrets mgmt

# Install Secret Mgmt Module (the engine)
Install-Module -Name Microsoft.PowerShell.SecretManagement -AllowPrerelease -Repository PSGallery

# Install Secret Management Store (the translator & storage)
Install-Module -Name Microsoft.PowerShell.SecretStore -AllowPrerelease -Repository PSGallery

#PowerShellv5
Install-Module PowerShellGet -Allow Clobber
# logoff PS Session then relaunch and install Secrets Modules

#Build a vault
Register-SecretVault -Name VaultDemo -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault -AllowClobber

# Where is the vault password? Not required to build vault

#add a Secret
set-secret TextString -Secret "This is just some text"
Set-Secret APIKey -Secret "c6854da1-743d-4234-bdd0-3f9832185b01"

#recall a secret
Get-Secret TextString

#save to a variable
$a = Get-Secret TextString


#add a PSCredential Object
Set-Secret -name CredMK -Secret (Get-pscredential)

#dont make this mistake
Set-Secret (Get-pscredential)








# call a secret on the fly

# delete a secret

# show vault info
## show



