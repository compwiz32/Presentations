# RTPSUG - Getting started with Azure DevOps Services

## Demo Intro

- How to run to get started running scheduled jobs / automation in the cloud
- geared for sysadmins
- lots of choices - let's boil it down to what you need to get started

##  Who Am I? 

- Microsoft MVP / Leader RTPSUG
- AD Engineer / PowerShell Tools & Automation

##  What are AZDevOps Svcs

- Azure DevOps website: https://dev.azure.com/your-AZDevops-Acct
- a collection of tools to help build and maintain automation
- automation can run in the cloud or on-premises
- enterprise grade automation services
- Free service - ok 
- Five major parts:
  <img src="C:\Scripts\GitRepos\Presentations\2021-09 RTPSUG AZDevOps Demo\azdevops-services.png"  />

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

