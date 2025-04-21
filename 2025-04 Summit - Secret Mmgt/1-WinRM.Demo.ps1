# throw "F8 to run selection!! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Show Sidebar: CTRL + B
# Show Terminal: CTRL + J
# Fold All Regions: Ctrl+K Ctrl+0
# Unfold All Regions: Ctrl+K Ctrl+J

#endregion

#region - 4 SLIDES - THEN COME BACK

#endregion

# MK - Connect to VPN!!!!

#region - WinRM Demo


# intro what remoting is - secure session from cmd line
cd c:\
cls

# lets see who we are logged is as on the console
whoami

# Demo remoting with no credential to DC (this will fail)
Enter-PSSession PRDUS4DC01


# Demo remoting with no credential to DC with alternate creds
cls
Enter-PSSession PrdUS4DC01 -Credential (Get-Secret CredMKAdmin)

#now let's see who we're logged in as on remote shell
whoami

#log off server
Exit-PSSession

#now let's see who we're logged in as
whoami

#endregion

#region - Switch to Slides (architecture)
#endregion


#region - END - next demo tab
#endregion
