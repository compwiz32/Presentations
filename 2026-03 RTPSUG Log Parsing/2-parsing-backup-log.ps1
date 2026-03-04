#region SECTION 1: Reading the file

# Get-Content reads a text file and returns each line as a string.
Clear-Host
Get-Content -Path .\2-backup_jobs.txt


#let's save for future use
clear-host
$backuplog = Get-Content -Path .\2-backup_jobs.txt


# What did we get back?
Clear-Host
$BackupLog

# How many lines?
Clear-Host
$BackupLog.Count

# A single line is just a plain string - no structure yet
Clear-Host
$BackupLog[0]

Clear-Host
$BackupLog[0].GetType()

Clear-Host
$backuplog | Get-Member

#endregion


#region SECTION 2: Searching with Select-String

# Select-String is your first tool for finding things in a log file.
# Think of it as a PowerShell version of Ctrl+F or Grep in Linux.
# Find all lines that mention a specific target
Clear-Host
Select-String -Path .\2-backup_jobs.txt -Pattern 'VM-APP-02'

#use of variable
Clear-Host
$backuplog | Select-String  -Pattern 'VM-APP-02'


# Find all failures
Clear-Host
Select-String -Path .\2-backup_jobs.txt -Pattern 'FAILED'

# same with variable
$backuplog | Select-String  -Pattern 'FAILED'


# What does Select-String actually return?

# $log is just strings - String methods and properties
#for each example - check the typenames at top of get-member
Clear-Host
$backuplog | Get-Member

# Select-String returns a completely different object type - MatchInfo
Clear-Host
$backuplog | Select-String -Pattern 'FAILED' | Get-Member


# The useful properties - LineNumber and Line
Clear-Host
Select-String -Path .\2-backup_jobs.txt -Pattern 'FAILED' |
Select-Object LineNumber, Line


# How many failures are there?
Clear-Host
(Select-String -Path .\2-backup_jobs.txt -Pattern 'FAILED').Count


Select-String -Path .\2-backup_jobs.txt -Pattern 'FAILED' | Measure-Object

#endregion


#region SECTION 3: Building on Select-String

# Search for multiple patterns at once - OR logic
Clear-Host
Select-String -Path .\2-backup_jobs.txt -Pattern 'FAILED', 'WARNING' |
Select-Object LineNumber, Line

# -SimpleMatch when you want plain text, no special characters interpreted
# Good habit when your search term could contain dots, brackets, etc.
Clear-Host
Select-String -Path .\2-backup_jobs.txt -Pattern 'snapshot creation error' -SimpleMatch |
Select-Object LineNumber, Line

# -NotMatch to find everything EXCEPT a pattern
# What does a healthy log look like? Everything that isnt a failure or warning
# Mk check line 14 of log file
Clear-Host
Select-String -Path .\2-backup_jobs.txt -Pattern 'FAILED', 'WARNING' -NotMatch |
Select-Object LineNumber, Line

# Search across multiple files at once
Clear-Host
Select-String -Path .\*.txt -Pattern 'FAILED' |
Select-Object Filename, LineNumber, Line

#endregion


#region SECTION 4: Turning lines into objects

# Select-String is great for finding lines.
# But to filter, sort, group, and do math - we need real objects.
#
# Our log has a consistent structure on every line:
# Date Time JobName Target Type Status DurationMin SizeGB "Message"
#
# We can teach PowerShell what each field means using a pattern.
# Each (?<Name>) block says "grab this chunk of text and call it Name"
Clear-Host
$pattern = '^(?<Date>\d{4}-\d{2}-\d{2}) (?<Time>\d{2}:\d{2}:\d{2}) (?<JobName>\w+) (?<Target>[\w-]+) (?<Type>\w+) (?<Status>\w+) (?<Duration>\d+) (?<SizeGB>[\d.]+)'

# Test the pattern on one line first - True means it matched
Clear-Host
$BackupLog[0] -match $pattern

# Look at what was captured
Clear-Host
$Matches

# Now parse every line into an object
Clear-Host
$jobs = Get-Content -Path .\2-backup_jobs.txt | ForEach-Object {
    if ($_ -match $pattern) {
        [PSCustomObject]@{
            DateTime = [datetime]"$($Matches.Date) $($Matches.Time)"
            JobName  = $Matches.JobName
            Target   = $Matches.Target
            Type     = $Matches.Type
            Status   = $Matches.Status
            Duration = [int]$Matches.Duration
            SizeGB   = [double]$Matches.SizeGB
        }
    }
}

# Real objects with real properties now
Clear-Host
$jobs | Format-Table

# Get-Member shows us the property names and their data types
Clear-Host
$jobs | Get-Member

#endregion


#region SECTION 5: Filtering with Where-Object

# Show only failed jobs
Clear-Host
$jobs | Where-Object Status -eq 'FAILED' | Format-Table

# Everything for one specific target
Clear-Host
$jobs | Where-Object Target -eq 'FS-CORP-02' | Format-Table

# Combine conditions - failed NightlyFull jobs only
Clear-Host
$jobs | Where-Object { $_.JobName -eq 'NightlyFull' -and $_.Status -eq 'FAILED' } | Format-Table

# Duration is a real number - we can use comparison operators
Clear-Host
$jobs | Where-Object Duration -gt 45 | Format-Table

#endregion


#region SECTION 6: Counting and Grouping

# How many jobs total?
Clear-Host
$jobs.Count

# How many failed?
Clear-Host
($jobs | Where-Object Status -eq 'FAILED').Count

# Break down by status
Clear-Host
$jobs | Group-Object -Property Status | Select-Object Name, Count | Sort-Object Count -Descending

# Which targets are failing and how many times?
Clear-Host
$jobs | Where-Object Status -eq 'FAILED' |
Group-Object -Property Target |
Select-Object Name, Count |
Sort-Object Count -Descending

#endregion


#region SECTION 7: Measure-Object

# Duration and SizeGB are real numbers so we can do math on them
# Total data backed up across successful jobs
Clear-Host
$jobs | Where-Object Status -eq 'SUCCESS' |
Measure-Object -Property SizeGB -Sum

# Average, min and max job duration
Clear-Host
$jobs | Measure-Object -Property Duration -Average -Minimum -Maximum

#endregion


#region SECTION 8: Exporting results

# Export failed jobs to CSV
Clear-Host
$jobs | Where-Object Status -eq 'FAILED' |
Export-Csv -Path .\failed_jobs.csv -NoTypeInformation

# Export everything to Excel with formatting
Clear-Host
$jobs | Export-Excel -Path .\backup_report.xlsx -AutoSize -AutoFilter -WorksheetName 'All Jobs'

# Multiple worksheets - the crowd pleaser
Clear-Host
$jobs | Export-Excel -Path .\backup_report.xlsx -AutoSize -AutoFilter -WorksheetName 'All Jobs'

$jobs | Where-Object Status -eq 'FAILED' |
Export-Excel -Path .\backup_report.xlsx -AutoSize -WorksheetName 'Failed Jobs'

$jobs | Group-Object Status | Select-Object Name, Count |
Export-Excel -Path .\backup_report.xlsx -AutoSize -WorksheetName 'Summary'

#endregion