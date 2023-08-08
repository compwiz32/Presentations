# NYPSUG Demo: Useful Links

### PowerShell Gallery Links

- [SecretManagement Module](https://www.powershellgallery.com/packages/Microsoft.PowerShell.SecretManagement/)
- [SecretStore](https://www.powershellgallery.com/packages/Microsoft.PowerShell.SecretStore/)

- Find SecretManagement Vaults:
    ```
    $SelectParams ='Name', 'Author', 'CompanyName', 'Version'
    find-module -tag "secretManagement" | Select-Object $SelectParams
    ```

### Useful Blog Posts

- [4sysops - SecretManagement for PowerShell](https://4sysops.com/archives/secretsmanagement-module-for-powershell-save-passwords-in-powershell/)
- [Thomas Maurer - SecretManagement and AZKeyVault](https://www.thomasmaurer.ch/2021/04/stop-typing-powershell-credentials-in-demos-using-powershell-secretmanagement/)


### Microsoft PowerShell Team Blog Posts
- [Announcing SecretManagement 1.1 GA](https://devblogs.microsoft.com/powershell/announcing-secretmanagement-1-1-ga/)
- [SecretManagement and SecretStore Release Candidates - (good background info)](https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-release-candidates/)


### SecretManagement Video Demos:
- [Mike Kanakos - previously recorded demos](https://www.youtube.com/results?search_query=mike+kanakos+secretmanagement)
- [John Savill Secret Management Explainer](https://www.youtube.com/watch?v=7b0KGVI4VLY)