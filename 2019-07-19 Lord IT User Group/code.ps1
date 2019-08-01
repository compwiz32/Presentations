
#pull service status
get-service BITS
Stop-service BITS
Start-Service BITS

#pipeline
Get-service BITS | Stop-service BITS

#pull service status
$svrs = 'crd-fs-wp01','crd-fs-wp02'
$svrs | ForEach-Object {get-service bits}


#pull data to form a list
get-adcomputer -filter "operatingsystem -like '*2016*'" -prop operatingsystem  | select name, operatingsystem

#pull a more complex list
get-adcomputer -filter "operatingsystem -like '*2016*' -and name -like 'crd*'" -prop operatingsystem  | select name, operatingsystem

#create a list to go back to
$svrsCRD = get-adcomputer -filter "operatingsystem -like '*2016*' -and name -like 'crd*'" -prop operatingsystem  | select name, operatingsystem

$svrsCRD | ForEach-Object {get-service bits}
$svrsCRD | ForEach-Object {stop-service bits}
$svrsCRD | ForEach-Object {start-service bits}

#Pull user info
Get-aduser Michael_kanakos

#Build your own lookups
get-employeeinfo Michael_kanakos

# perform searches
get-aduser -filter "name -like 'smith*' " -prop * | select name, office, city, *phone* | ft

#more complex 
get-aduser -filter "name -like 'smith*' -and city -eq 'cary' " -prop * | select name, City | sort city


#ask for more data
get-aduser -filter "name -like 'smith*' " -prop * | select name, office, city, *phone* | ft 

#save the data for later use
$crdusers = get-aduser -filter "name -like 'smith*' " -prop * | select name, office, city, *phone* | ft 

#exporting data
$crdusers | export-csv C:\scripts\Output\democsv.csv -NoTypeInformation
$crdusers | ConvertTo-Html | out-file C:\Scripts\Output\demohtml.htm
$crdusers | Export-Excel -FreezeTopRow