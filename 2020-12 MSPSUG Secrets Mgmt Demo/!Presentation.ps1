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

#Highlevel plan

#Install Modules
Install-Module -Name Microsoft.PowerShell.SecretManagement -AllowPrerelease -Repository PSGallery
Install-Module -Name Microsoft.PowerShell.SecretStore -AllowPrerelease -Repository PSGallery

#Build a vault

#add a Secret

#add a PSCredential Object

#recall a secret

#save to a variable

# call a secret on the fly

# delete a secret

# show vault info
## show



