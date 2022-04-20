# Build a self-service portal with WebJEA
- Config process is detailed on WebJEA GitHub portal.
- The steps below are for my build process



## WebJEA Build Process

### Build a server

### Pull down latest WebJEA release

- https://github.com/markdomansky/WebJEA

### Unzip files to folder named C:\WebJEA

### Create a cert for server

- Use Self Signed cert if you have no central cert store

```PowerShell
New-SelfSignedCertificate -DnsName MKTestCert.mk.lab -CertStoreLocation "Cert:\LocalMachine\My"
```

### Browse to folder and  modify the DSCDeploy.ps1 with:

- machine name
- certificate thumbprint
- Service Account name / MSA
- deployment folder name and path

### Execute DSCDeploy.ps1 configuration

- This will download and install the necessary DSC modules, the latest package, then start installation.

### Configure IIS Authentication

- set website to integrated authentication if you want it to automatically assign user rights

### Configure the JSON

### Reboot computer

### Check Website

- https://FQDN/webjea

### Install Modules for Scripts (use -scope AllUsers for all modules)

## Optional Steps

### Install Additional Apps

```PowerShell
# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#Install Apps
Choco install VSCode, Notepadplusplus, gsudo, Powershell-core, git -y
```