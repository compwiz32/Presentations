# Download the package
function download() {$ProgressPreference="SilentlyContinue"; Invoke-WebRequest -Uri https://aka.ms/AzureConnectedMachineAgent -OutFile AzureConnectedMachineAgent.msi}
download

# Install the package
msiexec /i AzureConnectedMachineAgent.msi /l*v installationlog.txt /qb | Out-String

# Run connect command
& "$env:ProgramFiles\AzureConnectedMachineAgent\azcmagent.exe" connect --resource-group "ArcDemo" --tenant-id "fe04c83e-84d1-4c30-842b-14c667a151aa" --location "eastus" --subscription-id "135294c4-d5e0-49d8-9e2a-7aff79388384" --cloud "AzureCloud" --tags "Datacenter=Foo,City='Holly Springs',StateOrDistrict=NC"
if($LastExitCode -eq 0){Write-Host -ForegroundColor yellow "To view your onboarded server(s), navigate to https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.HybridCompute%2Fmachines"}









# Download the installation package
wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh

# Run connect command
azcmagent connect --resource-group "Default-ActivityLogAlerts" --tenant-id "fe04c83e-84d1-4c30-842b-14c667a151aa" --location "eastus" --subscription-id "135294c4-d5e0-49d8-9e2a-7aff79388384" --cloud "AzureCloud" --tags "Datacenter=Foo,City='Holly Springs',StateOrDistrict=NC,Region=EastUS"
if [ $? = 0 ]; then echo "\033[33mTo view your onboarded server(s), navigate to https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.HybridCompute%2Fmachines\033[m"; fi



Backup-GroupPolicy -path C:\Backup -Domain nwtraders.local -Server DC01

@(

)