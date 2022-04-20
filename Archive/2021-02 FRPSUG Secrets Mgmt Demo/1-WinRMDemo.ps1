# intro what remoting is
# secure session from cmd line


# passwords in PowerShell the old way!
$theoldway = Get-credential mklab\mkana

# Extract the password - insecure
$theoldway.Password | ConvertFrom-SecureString -AsPlainText

# Demo remoting with no credential to DC (this will fail)
Enter-PSSession DC01

# Demo Secret Mgmt password Recall
enter-pssession DC01 -Credential (get-secret credmkadmin)


# Which user?
whoami

# what machine name?
hostname

# switch to demo slide