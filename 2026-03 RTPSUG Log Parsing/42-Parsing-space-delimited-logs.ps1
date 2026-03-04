## 2 - Parsing data from a plain text log
# Unlike CSV, text logs have no guaranteed structure
# Could be space-delimited, pipe-delimited, fixed-width, or just freeform
# First question is always: what does this file actually look like?

# READING THE FILE

#MK Make sure your in the right directory
Set-Location 'C:\git\Presentations\2026-03 RTPSUG Log Parsing'


# Get-Content reads any text file line by line
Clear-Host
Get-Content -Path .\2-server_errors.txt

Clear-Host
$svrlog = Get-Content -Path .\2-server_errors.txt


# What did we get back?
# just strings - no properties to work with yet
Clear-Host
$svrlog | Get-Member


# how many lines
Clear-Host
$svrlog.Count


# eyeball the structure
Clear-Host
$svrlog | Select-Object -First 5


# single line - notice zero-based index here too
Clear-Host
$svrlog[0]


# SEARCHING WITH SELECT-STRING

# Select-String is PowerShell's grep
# Searches for a pattern and returns matching lines
Clear-Host
Select-String -Path .\2-server_errors.txt -Pattern 'ERROR'

Clear-Host
Select-String -Path .\2-server_errors.txt -Pattern 'Error'

Clear-Host
Select-String -Path .\2-server_errors.txt -Pattern '*Error'
# look at the error after execution


Select-String -Path .\2-server_errors.txt -SimpleMatch 'Error'

Clear-Host
$svrlog | Select-String -Pattern 'ERROR'


# What does Select-String actually return?
$svrlog | Select-String -Pattern 'ERROR' | Get-Member
# MatchInfo objects - not plain strings. Notice: Filename, LineNumber, Line


# More useful view
$svrlog | Select-String  -Pattern 'ERROR' |
Select-Object LineNumber, Line |
Format-Table -Wrap


# How many errors?
($svrlog | Select-String  -Pattern 'ERROR').Count


# Compare levels
($svrlog | Select-String  -Pattern 'INFO').Count
($svrlog | Select-String  -Pattern 'WARN').Count
($svrlog | Select-String  -Pattern 'CRITICAL').Count


# Search for multiple patterns at once
Clear-Host
$svrlog | Select-String  -Pattern 'ERROR', 'CRITICAL' | Select-Object LineNumber, Line


# Context - show lines around a match (great for debugging)
# What was happening just before a CRITICAL?
Clear-Host
$svrlog | Select-String  -Pattern 'CRITICAL' -Context 2, 0 |
Format-List

# Specific endpoint - is /api/checkout causing problems?
Clear-Host
$svrlog | Select-String  -Pattern '/api/checkout' |
Select-Object LineNumber, Line


# Combine patterns - errors on a specific endpoint
Clear-Host
$svrlog | Select-String  -Pattern 'ERROR' | Where-Object Line -like '*checkout*' | Select-Object LineNumber, Line

# ── EXTRACTING SPECIFIC VALUES ───────────────────────────────────────────────

# What if we only want the matched text itself?
# The Matches property holds what the regex actually captured
Clear-Host
$svrlog | Select-String  -Pattern '\d{3}' | Select-Object -ExpandProperty Matches | Select-Object -ExpandProperty Value

# Named capture groups make intent explicit
Clear-Host
$svrlog | Select-String  -Pattern '(?<StatusCode>\d{3})' | ForEach-Object { $_.Matches.Groups['StatusCode'].Value } | Sort-Object -Unique

# ── TURNING TEXT INTO OBJECTS ────────────────────────────────────────────────

# Strings are a dead end - we can't group, sort, or filter on fields
# We need to parse the structure out and build real objects
# Look at a line again and identify the fields
$svrlog[0]

# Build a regex that matches each field by name
$pattern = '^(?<Date>\d{4}-\d{2}-\d{2}) (?<Time>\d{2}:\d{2}:\d{2}) (?<Level>\w+)\s+(?<Server>\w+) (?<Code>\d+) (?<Path>\S+)'






# Parse every line into a PSCustomObject
$logs = Get-Content .\server_errors.txt | ForEach-Object {
    if ($_ -match $pattern) {
        [PSCustomObject]@{
            DateTime = [datetime]"$($Matches.Date) $($Matches.Time)"
            Level    = $Matches.Level
            Server   = $Matches.Server
            Code     = [int]$Matches.Code
            Path     = $Matches.Path
        }
    }
}

# Now check what we have
$logs | Get-Member                 # real properties now - not just strings
$logs.Count
$logs | Select-Object -First 5 | Format-Table

# ── FILTERING AND GROUPING ───────────────────────────────────────────────────

# Everything from the CSV demo now applies
$logs | Group-Object -Property Level | Select-Object Name, Count | Sort-Object Count -Descending

# Which servers are generating the most errors?
$logs | Where-Object Level -eq 'ERROR' |
Group-Object -Property Server |
Select-Object Name, Count |
Sort-Object Count -Descending

# Which endpoints are the most problematic?
$logs | Where-Object Level -in 'ERROR', 'CRITICAL' |
Group-Object -Property Path |
Select-Object Name, Count |
Sort-Object Count -Descending

# ── HUNTING THE PATTERNS ─────────────────────────────────────────────────────

# Pattern 1 - bad deploy: error spike on /api/checkout
# What does the error rate look like over time on that endpoint?
$logs | Where-Object Path -eq '/api/checkout' |
Select-Object DateTime, Level, Server, Code |
Format-Table

# Pattern 2 - off hours scanning: late night 404s on /admin paths
$logs | Where-Object { $_.Path -like '/admin*' -and $_.DateTime.Hour -lt 6 } |
Select-Object DateTime, Level, Server, Code, Path |
Format-Table

# Pattern 3 - cascade failure: 502s and 503s across multiple servers
$logs | Where-Object Code -in 502, 503 |
Group-Object -Property Server |
Select-Object Name, Count |
Sort-Object Count -Descending

# What time window did the cascade happen in?
$logs | Where-Object Code -in 502, 503 |
Select-Object DateTime, Server, Code, Path |
Sort-Object DateTime |
Format-Table

# Pattern 4 - memory leak: same endpoint, escalating severity
$logs | Where-Object Path -eq '/api/reports' |
Group-Object -Property Level |
Select-Object Name, Count

$logs | Where-Object Path -eq '/api/reports' |
Select-Object DateTime, Level, Server, Code |
Sort-Object DateTime |
Format-Table

# Pattern 5 - expired service account: 401s isolated to one server
$logs | Where-Object Code -eq 401 |
Group-Object -Property Server, Path |
Select-Object Name, Count