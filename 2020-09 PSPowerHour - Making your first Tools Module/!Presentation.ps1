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
$DemoRoot = 'C:\Scripts\mk\GitRepos\foundational-and-identity\zStaff\Mike\SoCalPSUG-Demo'
$DemoModuleSimple = 'C:\Scripts\MK\GitRepos\foundational-and-identity\zStaff\Mike\SoCalPSUG-Demo\DemoModuleSimple'
$DemoModuleWithManifest = 'C:\Scripts\MK\GitRepos\foundational-and-identity\zStaff\Mike\SoCalPSUG-Demo\DemoModuleWithManifest'
$DemoModulePublicPrivate = 'C:\Scripts\MK\GitRepos\foundational-and-identity\zStaff\Mike\SoCalPSUG-Demo\DemoModulePublicPrivate'
$UserModuleFolder = 'C:\Users\mkanakos\Documents\PowerShell\Modules'

#endregion

#region - presentation prep
Remove-Item C:\Users\mkanakos\Documents\PowerShell\Modules\DemoModulePublicPrivate -Recurse
Remove-Module demo*

#endregion

#region - Show functions used in demo
Set-Location "$DemoRoot\functions"
Get-ChildItem get*

#endregion

#region - Show installed modules
Get-Module Demo*

#endregion

#region ----- DemoModuleSimple

    #region - Show DemoModuleSimple PSM file
    ### browse to file in VSCODE ###

    #endregion

    #region - Load DemoModuleSimple PSM
    Import-Module $DemoModuleSimple\DemoModuleSimple.psm1

    #endregion

    #region - List Functions in module / Show Module Info
    get-module demo*
    get-command -module DemoModuleSimple
    get-module DemoModuleSimple | Format-List

    #endregion

    #region - Run Functions
    Get-PCInfo
    Get-DriveInfo
    Get-PCUptime

    #endregion

#endregion

#region ----- DemoModuleWithManifest

    #region - Show PSM and PSD from DemoModuleWithManifest
        ### browse to file in VSCODE ###
        ### point out module version in PSD ###

    #endregion

    #region - Create Manifest Hashtable for DemoModuleWithManifest

        $manifest = @{
            Path          = ".\DemoModulewithManifest.psd1"
            RootModule    = 'DemoModulewithManifest.psm1'
            Author        = 'Mike Kanakos'
            ModuleVersion = '0.6.0'
        }

    #endregion

    #region - Show Hashtable
    $manifest

    #endregion

    #region - Rename current PSD Manifest
    rename-item "$DemoModuleWithManifest\DemoModulewithManifest.psd1" 'DemoManifest.old'

    #endregion

    #region - Create new PSD Manifest
    New-ModuleManifest @manifest

    #endregion

    #region - Load DemoModuleWithManifest PSD
    Import-Module $DemoModuleWithManifest\DemoModuleWithManifest.psd1

    #endregion

    #region - Get Module Details
    Get-Module DemoModuleWithManifest
    Get-Module DemoModuleWithManifest | Format-List

    #endregion

#endregion

#region ----- DemoModulePublicPrivate

    #region - Show DemoModulePublicPrivate folder structure
    ### browse to files in VSCODE ###
    ### highlight how PSM file is setup ###
    ### highlight the PSD file differences ###

    #endregion

    #region - Show hashtable for Manifest (DO NOT RUN CODE)

    ### DO NOT RUN THIS CODE ###
    $manifest = @{
        Path          = "$DemoPublicPrivate\DemoModulewithManifest.psd1"
        RootModule    = 'DemoModulewithManifest.psm1'
        Author        = 'Mike Kanakos'
        ModuleVersion = '0.8.0'
    }

    New-ModuleManifest @manifest

    #endregion

    #region - Import DemoModulePubPriv PSD
    Import-Module $DemoModulePublicPrivate\DemoModulePublicPrivate.psd1

    #endregion

    #region - Uninstall Modules
    Remove-Module -name DemoModuleSimple -Force

    #endregion

    #region - Show PSModulePath
    $env:PSModulePath -split ";"

    #endregion

    #region - Check modules available for install
    Get-module -ListAvailable dem*

    #endregion

    #region - Copy DemoModulePubPriv to Modules folder
    copy-item $DemoRoot\DemoModulePublicPrivate -Recurse $UserModuleFolder

    #endregion

    #region - Check AGAIN for modules available for install
    Get-module -ListAvailable dem*

    #endregion

    # Region - Import DemoModulepubPriv Module
    import-module DemoModulePublicPrivate

    #endregion

    #region - Show auto import of  module from commands
    Remove-Module Demo*

    #endregion

    #region - Show module is still available
    Get-module -ListAvailable Demo*

    #endregion

    #region - Run a function from the module
    Get-PCUpTime

    #endregion

#endregion


#region ----- Publish Module to PowerShellGallery

    #region - Create hashtable for module Publish
    $PublishParams = @{
        Name            = 'DemoModulePublicPrivate'
        NuGetApiKey     = $APIKey
        ReleaseNotes    = 'A demo module that shows how public and private functions work'
        LicenseURI      = 'http://contoso.com/license'
        Tag             = 'DemoModule'
    }

    #endregion

    #region - Publish Module to Gallery (DO NOT RUN)
    ### talk about how module needs to be loaded in memory for upload ###
    Publish-Module @PublishParams

    #endregion

    #region - Find Module on gallery
    Find-Module DemoModulePublicPrivate
    Find-Module DemoModulePublicPrivate | Format-List

    #endregion

#endregion
