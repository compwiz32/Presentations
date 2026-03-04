## 1 Parsing data from a CSV log

# What is a CSV file?
# structured data - looks liek spreadsheet file.
# 1st row - headers followed by rows of data. each data field ina  row is seprated bya comma
# hence the name CSV - comma separated values.

# We have the file > how do we read it?
# Import and immediately see what you have
$logs = Import-Csv -Path .\1-user_activity.csv

# How can we see information about the data contained in the CSV?
$logs | Get-Member

# What does the data actually look like?
$logs
$logs | Select-Object -First 5
$logs[25] # off by 2 - why?
$logs[50..57] | Format-Table

Clear-Host

# How many rows in the file
$logs.Count
$logs | Measure-Object
$logs | Measure-Object | Select-Object count

Clear-Host

# Count with filtering
($logs | Where-Object Status -eq 'FAILED').Count
$logs | group-object Status

Clear-Host

# working with data - out gridview
$logs | out-gridview
$jsmith = $logs | out-gridview -PassThru

# finding thigns with where-object
$logs | where-object username -like "jsmit*" | Format-Table
$logs | where-object { $_.username -like "jsmit*" -and $_.Action -like "login" } | Format-Table

$logs | Where-Object status -eq "failed" | Format-Table
$logs | Where-Object username -eq bjones | sort-object Status | Format-Table



$logs | Group-Object -Property Username


$logs | Group-Object -Property Username | Select-Object Name, Count | Sort-Object Count -Descending


$logs | Where-Object Status -eq 'FAILED' | Group-Object -Property Username | Select-Object Name, Count | Sort-Object Count -Descending

Clear-Host

# Multiple property grouping — who failed from which IP?
$logs | Where-Object Status -eq 'FAILED' | Group-Object -Property Username, IPAddress | Select-Object Name, Count

$logs | Where-Object Ipaddress -like "10.10.*" | Group-Object -Property IPAddress, UserName | Select-Object Name, Count


$logs | Where-Object { $_.Username -eq 'bjones' -and $_.Status -eq 'FAILED' } | Select-Object Timestamp, Username, Status, IPAddress | Format-Table