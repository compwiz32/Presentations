# How I Work

## Intro 

- Align Technology / Invisalign
  - Global company - 17k employees in US, APAC, EMEA, LATAM
  - Heavy DevOps and cloud usage
    - Azure for infra and Auth
    - AWS for DevOps / Software Dev
  - IAM engineer focused on AD, AAD, PKI, SSO, GPO, DNS, DHCP.  Also assist other teams with typical client/server BS

## Typical Day

- Focus on projects, but still do tickets for customer issues
  - most of my day is spent building automated tools, managing AD resources and setting up SSO related tasks
  - working over VPN for some resources, but many of our services are cloud based and therefore no VPN
  - I usually VPN into RDU office and then Invoke to other sites as needed for on-prem
  - straight to the cloud for Azure AD tasks
- I use multiple accounts to admin my network
- I use Windows Terminal and VSCODE extensively
  - Windows Terminal for interactive PS work (PS7 & PS5)
    - std acct and invoke-command
    - sometimes elevated PS Cmd prompt as admin accts
  - I use VSCode for script creation as std acct. Why?
    - access to our repos is assigned from our std users accts, I need to run VSCODE as std user to sync with git but that sometimes makes it hard for me to debug code that will be run under my admin ID

## Software List

Tools I use regularly:

- Win Terminal / PS5 / PS7
- VSCODE
- Git
- Az DevOps for scheduled jobs
- Ditto - clipboard mgr
- Evernote
- Teams
- ServiceNow (Day to Day issues)
- JIRA (Project Work)
- Confluence  (Wiki)
- Discord - PowerShell questions from community peeps 
- Notepad++
- Explorer++
- Typora for documentation
- Edge / Brave / Firefox browsers
- RoyalTS for RDP connections
- Choco



### PowerShell related Items

PS Modules I use:

- Export-Excel (DFinke)
- SecretManagement / SecretStore
- PSReadLine
- PSADHealth (my module)
- AzureAD
- PowerShellAccessControl (Rohn Edwards)
- AutomatedLab
- GSudo



## My Setup 

- customized PS cmd prompt
  - wrote article on how to config
- common profile for all my ID's
  - also article on how to config
  - 



