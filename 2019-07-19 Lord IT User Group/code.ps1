
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



get-aduser -filter "name -like 'smith*' " -prop * | select name, office, city, *phone* | ft


get-aduser -filter "name -like 'smith*' -and city -eq 'cary' " -prop * | select name, City | sort city

#exporting data


