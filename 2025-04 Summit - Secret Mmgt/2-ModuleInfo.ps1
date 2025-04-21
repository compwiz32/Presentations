throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J





#region - find the modules on PSGallery
# SecretMgmt Module
$SelectParams = "name", "author", "companyname", "version"
find-module "microsoft.powershell.secretmanagement" -Repository PSGallery | Select-Object $SelectParams | Format-List

#clean the screen
Clear-Host

# SecretMgmt vaults
find-module -tag "secretManagement" -Repository PSGallery | Select-Object name, author, companyname, version | Sort-Object name

#clean up
cls
#endregion


#region - Installing Modules (MK DO NOT RUN)

# Install Secret Mgmt Module (the engine)
Install-Module -Name Microsoft.PowerShell.SecretManagement -Repository PSGallery

# Install Secret Store (the translator & storage)
Install-Module -Name Microsoft.PowerShell.SecretStore -Repository PSGallery

#endregion