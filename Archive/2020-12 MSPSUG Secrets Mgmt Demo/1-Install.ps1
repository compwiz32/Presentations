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


# Links
# MS Blog Post
https://devblogs.microsoft.com/powershell/secretmanagement-preview-6-and-secretstore-preview-4/

# Secret Mgmt Module
https://www.powershellgallery.com/packages/Microsoft.PowerShell.SecretManagement/0.5.5-preview6

# Secret Store
https://www.powershellgallery.com/packages/Microsoft.PowerShell.SecretStore/0.5.4-preview4

# Secret Mgmt - KeePass
https://www.powershellgallery.com/packages/SecretManagement.KeePass/0.0.4.4



# passwords in PowerShell the old way!
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