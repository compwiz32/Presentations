# SoCal PSUG: Running on-prem automation with Azure DevOps Services

### Agenda

- How to run on-prem workloads from in the Azure cloud.. why?
- Walk thru services available
- Highlight why you want to consider ADevOps (Hint: Cost & features)
- Show off the interface / How to get started
- Explain the buttons and knobs
- Create some automation

### Who Am I?

- Microsoft MVP
- Infrastructure Tools Engineer: Invisalign
  - Azure AD, Azure DevOps, Active Directory, Build PowerShell Tools & Automation
- Leader RTPSUG

### Why AzDevOps?
- AZ DevOps can handle all sizes of automation
- Lots of choices: Let's simplify the options
- Very affordable automation solution for ANY size business
- AZ DevOps can handle multiple languages

### What are AZDevOps Svcs?

- Azure DevOps website: https://dev.azure.com/your-AZDevops-Acct
- Collection of tools to help build and maintain automation
- Automation can run in the cloud or on-premises
- Enterprise grade automation services
- SAAS - MS maintains the environment
- Can be a completely free service!!!

### AZDevops Svcs Breakdown:

- Five major parts:
![AzDevopsSvcs](AZDevops-Services.png)

### AzDevOps vs Task Scheduler?
-



## Azure DevOps Cost

- cost calculator - https://azure.microsoft.com/en-us/pricing/calculator/
- surprisingly cheap - you can absolutely run AzDevOps for $0

## My Lab Setup

- on-prem domain: Active Directory
- cloud: AzureAD
- automation engine: AZ DevOps
  - git repo: my code
  - pipelines: engine
  - Project: where all my settings live

## First Steps with Azure DevOps

- Azure DevOps website: https://dev.azure.com/
- setup an acct
- make a project
- turn off what you don't need
- setup a repo
- commit code
- setup a job

## AZ DevOps Interface

### Projects

- Overview (shut off AZ DevOps services)
- Permissions (self explanatory)
- Notifications
- Settings (days to keep data)
- Agent Pools

### AZ Build Agent Process

- download agent
- create PAT
- unzip & install agent
- follow cmd line prompts

<img src="C:\Scripts\GitRepos\Presentations\2021-09 RTPSUG AZDevOps Demo\AZBuild-Config-Process.png" style="zoom:150%;" />



### Repo setup

- standard git setup

### Pipelines

- default view is history
  - job name - last run - run time
- jobs
  -
- library
  - variables / variable groups
  - link to jobs

