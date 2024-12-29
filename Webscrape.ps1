#need to check this page for an article modify date change
$URI = 'https://learn.microsoft.com/en-us/azure/security/fundamentals/azure-ca-details?tabs=root-and-subordinate-cas-list'


#region - Invoke-WebRequest - No content is included
$FirstTry = Invoke-webrequest $uri

#endregion


#region - let's try with Invoke-RestMethod - Yay! we seee the content
$secondTry = Invoke-RestMethod $URI

#endregion


#region - pattern we are looking for

# sample pattern: <meta name="ms.date" content="04/19/2024" />
# regex that works: (.*?)

$pattern = '<meta name="ms\.date" content=(.*?)\/>'

#endregion


#region - test the pattern
$pattern = '<meta name="ms\.date" content=(.*?)\/>'
$HTML = Invoke-RestMethod $URI
$HTML -match $pattern

#endregion


#region - see the matches
$Matches

$matches.1

#endregion

#region - put it all together
$URI = 'https://learn.microsoft.com/en-us/azure/security/fundamentals/azure-ca-details?tabs=root-and-subordinate-cas-list'
$pattern = '<meta name="ms\.date" content=(.*?)\/>'
$HTML = Invoke-RestMethod $URI
$HTML -match $pattern | Out-Null
$Matches.1

#endregion






Try {
    Test-Connection "fakesystem" -Count 1 -ErrorAction 'Stop'
} Catch [System.Net.NetworkInformation.PingException] {
    "Ping Exception"
} Catch {
    "Unknown Exception"
}



Clear-Host
try {
    # Code that may throw exceptions
    Get-ChildItem -Path "C:\temp2" -ErrorAction Stop
} catch [System.Management.Automation.ItemNotFoundException] {
    Write-Host "Folder not found."
} catch [System.Management.Automation.MethodInvocationException] {
    Write-Host "Error invoking method."
} catch {
    Write-Host "An error occurred"
}



try {
    # The code that may throw an exception goes here
    $result = 10 / 0
} catch [System.Management.Automation.ItemNotFoundException] {
    Write-Host "The specified folder does not exist."
} catch {
    Write-Host "An error occurred: $_"
}


try {
    $file = [System.IO.File]::OpenWrite("C:\example.txt")
    Write-Output "File opened for writing."

    # Code that writes to the file
    $file.WriteLine("Hello, World!")
} catch {
    Write-Host "An error occurred: $_"
} finally {
    if ($file -ne $null) {
        $file.Close()
        Write-Output "File handle closed."
    }
}
