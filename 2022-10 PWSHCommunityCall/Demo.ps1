
#region Variables

$ClientID = "43ea1d28-c022-49c1-8c1f-1cf15989231d"
$ClientSecret = "1cu8Q~hcmjyp0MnlsyDXUfFDrZna.FZHkTGXucqC"
$TenantID = "fe04c83e-84d1-4c30-842b-14c667a151aa"
$Credential = ConvertTo-GraphCredential -ClientID $ClientID -ClientSecret $ClientSecret -DirectoryID $TenantID

$MailSender = "mkanakos@gmail.com"
$MailSubject = "My Awesome PWSH demo"
$MailTo = "mkanakos@gmail.com"


Connect-AzAccount -ServicePrincipal -Tenant $TenantID -Credential (Get-Secret CredAZ-SvcPrinc-MVPAcct )
$AzAccessToken = (Get-AzAccessToken -ResourceTypeName MSGraph).Token
Connect-MgGraph -AccessToken $AzAccessToken

#endregion


#region emailbody

$EmailBody2 = EmailBody {

    EmailText -Text "Hello $($User.GivenName)!" -LineBreak

    EmailText -Text "Giant welcome from [Productivity Engineering team](https://wiki.aligntech.com/display/PEPU/ProductivityEngineeringPublic+Home)!" -FontWeight bold -LineBreak

    EmailText -Text "Before your journey at Align starts, we would like to give you more information to help you get oriented among Tooling services." -LineBreak

    EmailText -Text "What We Do" -FontWeight bold -LineBreak -TextDecoration underline

    EmailText -Text "We provide support for JIRA, WIKI, Bamboo, BitBucket, Artifactory and [other tools](https://wiki.aligntech.com/display/PEPU/ProductivityEngineeringPublic+Home) that are mostly used by development teams at Align. "

    EmailText -Text "All requests concerned with granting/changing permissions, updating settings, creating/cloning new items, bugs and issues can be addressed towards our team via email tooling@aligntech.com"  -LineBreak

    EmailText -Text "Initial access to JIRA" -FontWeight bold -TextDecoration underline

    EmailList {
        EmailListItem -Text 'Take ["Defect and Change Tracking for JIRA"](https://aligntechnology.sabacloud.com/Saba/Web_spf/NA1PRD0028/app/me/learningeventdetail;spf-url=common%2Fledetail%2Fcours000000000039567%3FfromAutoSuggest%3Dtrue) training in SABA.'
        EmailListItem -Text "Access to JIRA will be granted automatically within 4 hours after Training is taken"
    } -Type Ordered

    EmailText -Text "For additional JIRA permissions (edit, move, assign tickets in certain projects) please reach [JIRA project admins](https://wiki.aligntech.com/display/PEPU/JIRA+project+administrators+list) or create 'JIRA permission' issue in 'CM' JIRA project" -LineBreak



    EmailText -Text "Initial Access to WIKI" -FontWeight bold -LineBreak -TextDecoration underline

    EmailText -Text "Access to Wiki is granted automatically upon first login. Please use your Align credentials:"
    EmailList {
        EmailListItem -Text "Username: ", "Your email ID without domain. Example: msmith@aligntech.com - Username would be msmith" -FontStyle normal, italic
        EmailListItem -Text "Password: ", "The same password you use to login to your email." -FontStyle normal, italic
    }

    Emailtext -Text "For additional Wiki permissions (editing certain spaces) please reach [Wiki Space Admins](https://wiki.aligntech.com/display/PEPU/Confluence+space+administrators) or reach our team via email tooling@aligntech.com." -LineBreak

    EmailText -Text "Initial access to other tools" -FontWeight bold -TextDecoration underline -LineBreak

    EmailText -Text "Please check our [onboarding page](https://wiki.aligntech.com/display/PEPU/Onboarding+for+new+Align+employees) for access to other tools" -LineBreak

    EmailText -Text "Sincerely Yours,"
    EmailText -Text "Productivity Engineering Team"
}


$emailbody = EmailBody {

    EmailText -Text " Hi Everyone!"
}

#endregion


#region Mail Send

Send-EmailMessage -From $MailSender -To $MailTo -Cc $MailCC -Credential $Credential -HTML $EmailBody -Subject $MailSubject -Graph -Verbose


#endregion

