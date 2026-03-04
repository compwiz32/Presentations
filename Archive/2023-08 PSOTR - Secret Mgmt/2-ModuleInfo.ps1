throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J


#endregion


#region - find the modules on PSGallery
# SecretMgmt Module
find-module "microsoft.powershell.secretmanagement" | Select-Object name, author, companyname, version | Format-List

# SecretMgmt vaults
find-module -tag "secretManagement" | Select-Object name, author, companyname, version | sort name
#endregion


#region - Installing Modules (switch to Client02)

# Install Secret Mgmt Module (the engine)
Install-Module -Name Microsoft.PowerShell.SecretManagement -Repository PSGallery

# Install Secret Management Store (the translator & storage)
Install-Module -Name Microsoft.PowerShell.SecretStore -Repository PSGallery

#PowerShellv5
Install-Module PowerShellGet -Allow Clobber
# logoff PS Session then relaunch and install Secrets Modules
#endregion