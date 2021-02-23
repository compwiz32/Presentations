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



# passwords in PowerShell the old way!
$oldcred = Get-credential mklab\mkana

# Extract the password - insecure
$oldcred.Password | ConvertFrom-SecureString -AsPlainText


# a better way - secrets mgmt

#find all the modules available
find-module "microsoft.powershell.secretmanagement" | select name, author, companyname, version

find-module -tag "secretManagement" | select name, author, companyname, version


# Install Secret Mgmt Module (the engine)
Install-Module -Name Microsoft.PowerShell.SecretManagement -Repository PSGallery

# Install Secret Management Store (the translator & storage)
Install-Module -Name Microsoft.PowerShell.SecretStore -Repository PSGallery
Install-Module -Name SecretManagement.KeePass -Repository PSGallery

#PowerShellv5
Install-Module PowerShellGet -Allow Clobber
# logoff PS Session then relaunch and install Secrets Modules