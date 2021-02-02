
function Get-PCUptime {

    <#
    .SYNOPSIS
        Displays the current uptime and last boot time for one or more computers.

    .DESCRIPTION
        Displays the current uptime and last boot time for one or more computers by querying CIM data. Remote computers
        are queried via WINRM using CIMInstance.

    .PARAMETER ComputerName
            Then name of a computer to query. Valid aliases are Name, Computer, & PC.

    .EXAMPLE

        Get-PCUptime

        Days         : 40
        Hours        : 20
        Minutes      : 59
        TotalHours   : 981
        LastBootTime : 4/7/2020 10:38:44 AM

        Returns uptime stats for the local computer

    .EXAMPLE

        Get-PCUpTime | Format-Table

        Days Hours Minutes TotalHours LastBootTime
        ---- ----- ------- ---------- ------------
        53      22      17       1294 4/7/2020 10:38:44 AM

        Returns uptime stats for the local computer and display results in  table format

    .EXAMPLE

        $dc = 'DC01','DC02','DC03'

        Get-Uptime $dc | Format-Table -AutoSize

        Days Hours Minutes TotalHours LastBootTime          PSComputerName  RunspaceId
        ---- ----- ------- ---------- ------------          --------------  ----------
        12      0      59        289  5/19/2020 7:16:18 AM  DC01            82a3b9bb-951d-4864-a285-f901ae7e5899
        105     0      25       2520  2/16/2020 7:49:49 AM  DC02            732c32c4-1002-4b5e-9e9a-a541439de6d6
        205     9      57       4930  11/7/2019 10:17:50 PM DC03            114a7635-cd9d-4382-8698-4265dc4df087

        Returns uptime stats for three remote computers.

    .INPUTS
        Computername
        Accepts input from pipeline

    .OUTPUTS
        Output (if any)

    .NOTES
       NAME:           Get-PCUptime.ps1
       AUTHOR:         Mike Kanakos
       DATE CREATED:   2020-05-18
    #>


        [CmdletBinding()]
        param (
           [Alias("PC","Computer","Name")]
           [Parameter(
                ValueFromPipeline,
                ValueFromPipelineByPropertyName
                )]
           [string[]]
           $ComputerName = $env:COMPUTERNAME,

           [PSCredential]
           $Credential
        )

        process {
            $code = {
                $OSInfo = Get-CimInstance Win32_OperatingSystem
                $LastBootTime = $OSInfo.LastBootUpTime
                $Uptime = (New-TimeSpan -start $lastBootTime -end (Get-Date))

                $SelectProps =
                    'Days',
                    'Hours',
                    'Minutes',
                    @{
                        Name       = 'TotalHours'
                        Expression = { [math]::Round($Uptime.TotalHours) }
                    },
                    @{
                        Name       = 'LastBootTime'
                        Expression = { $LastBootTime }
                    }

                $Uptime | Select-Object $SelectProps
            } #End $code

            Invoke-Command -ScriptBlock $code @PSBoundParameters -ErrorAction SilentlyContinue -ErrorVariable NoConnect

            foreach($fail in $NoConnect) {
                Write-Warning "Failed to run on $($fail.TargetObject)"
            } #end foreach warning loop
        } #End Process
    } #end function

function Get-DriveInfo {


    <#
    .SYNOPSIS
        Lists information about drives for a computer

    .DESCRIPTION
        Lists information about drives for a computer. Displays information about disk space (free, consumed, etc).
        Also displays information about filesystem, if a pagefile is present, drive compression and
        boot volume information.

    .EXAMPLE
        PS C:\> Get-DriveInfo

        Name             : C:\
        DriveType        : FixedDisk
        TotalSize        : 99 GB
        UsedSpace        : 32 GB
        FreeSpace        : 67 GB
        PercentUsed      : 32 %
        Filesystem       : NTFS
        IsBootVolume     : True
        CompressedVolume : False
        ContainsPageFile : True

        Name             : D:\
        DriveType        : CD-Rom
        TotalSize        :
        UsedSpace        :
        FreeSpace        :
        PercentUsed      :
        Filesystem       :
        IsBootVolume     :
        CompressedVolume :
        ContainsPageFile :

        Displays list of drives and the information about each drive.

    .EXAMPLE
        PS C:\> Get-DriveInfo | Format-Table

        Name DriveType TotalSize UsedSpace FreeSpace PercentUsed Filesystem IsBootVolume CompressedVolume ContainsPageFile
        ---- --------- --------- --------- --------- ----------- ---------- ------------ ---------------- ----------------
        C:\  FixedDisk 99 GB     32 GB     67 GB     32 %        NTFS               True            False             True
        D:\  CD-Rom

        Displays drive information in a table format

    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
   .Notes
        NAME:        Get-DriveInfo.ps1
        AUTHOR:      Mike Kanakos
        VERSION:     1.0.1
        DateCreated: 2020-05-04
        DateUpdated: 2019-07-03

    .Link
        https://github.com/compwiz32/PowerShell
    #>



    [CmdletBinding()]
    Param(
        [Alias("Name","PC","Computer")]
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$ComputerName=$env:COMPUTERNAME
    )

    process {
        Foreach ($PC in $ComputerName){
            Write-Verbose "Testing that $PC is online"
            $online = Test-Connection -ComputerName $PC -Count 2 -Quiet
                if ($online -eq $true){
                    $DiskDrives = Get-CimInstance win32_volume -ComputerName $pc | Where-Object {$_.caption -notlike '*volume*'}
                        foreach ($disk in $DiskDrives) {
                            $DriveInfo = [PSCustomObject]@{
                                Name = $disk.caption
                                DriveType = if ($Disk.drivetype -like 3) {"FixedDisk"} else {"CD-Rom"}
                                "TotalSize" = if ($Disk.drivetype -like 3) {"$([math]::round((($disk.Capacity)/1GB),0)) GB"} else {}
                                "UsedSpace" = if ($Disk.drivetype -like 3) {"$([Math]::Round((($disk.Capacity-$disk.FreeSpace)/1GB),0)) GB"} else {}
                                "FreeSpace" = if ($Disk.drivetype -like 3) {"$([math]::round((($disk.FreeSpace)/1GB),0)) GB"} else {}
                                "PercentUsed" = if ($Disk.drivetype -like 3){"$([math]::round(((($disk.Capacity-$disk.FreeSpace)/$disk.Capacity)*100),0)) %"} else {}
                                Filesystem = $disk.Filesystem
                                IsBootVolume = $Disk.BootVolume
                                CompressedVolume = $Disk.Compressed
                                ContainsPageFile = $Disk.PageFilePresent
                            } #end custom object
                            $DriveInfo
                        } #end foreach $disk
                } #end if
        } #end foreach $pc
    } #end process block
}# end function


function Get-PCInfo {

    <#
    .SYNOPSIS
        Generates a summary of CPU, RAM, Disk and other metrics for one or more computers

    .DESCRIPTION
        Generates a summary of CPU, RAM, Disk and other metrics for a computer via CIM and Active Directory.
        Code supports querying data from multiple computers. Also, data from this cmdlet can be viewed with other views
         like Out-Gridview or exported with Export-CSV or Export-Excel.

    .PARAMETER ComputerName
        Then name of a computer to query. Valid aliases are Name, Computer, & PC.

    .EXAMPLE
        PS C:\> Get-PCInfo

        Name         : PRDUS2ITUTIL01
        Domain       : aligntech.com
        Description  :
        OS           : Microsoft Windows Server 2019 Standard
        ServicePack  : 0
        WindowsSN    : 00429-70000-00000-AA946
        Model        : VMware Virtual Platform
        MACAddress   : 00:50:56:8A:CB:1D
        IPAddress    : 10.16.157.68
        CPUInfo      : Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz, Number of Processors: 2
        RAM          : 8 GB
        DriveInfo    : {@{Name=C:\; DriveType=FixedDisk; TotalSize=99 GB; UsedSpace=31 GB; FreeSpace=68 GB;
                        PercentUsed=31 %; Filesystem=NTFS; IsBootVolume=True; CompressedVolume=False;
                        ContainsPageFile=True}, @{Name=D:\; DriveType=CD-Rom; TotalSize=; UsedSpace=; FreeSpace=;
                        PercentUsed=; Filesystem=; IsBootVolume=; CompressedVolume=; ContainsPageFile=}}
        LastBootTime : 4/7/2020 10:38:44 AM
        UpTime       : 30 Days, 2 Hours, 58 Minutes

        Returns info for local PC

    .EXAMPLE

    PS C:\> Get-PCInfo -computername PRSCEFTP01 -OutVariable FOO

        Name         : PRSCEFTP01
        Domain       : aligntech.com
        Description  : eFTP.
        OS           : Microsoft Windows Server 2008 R2 Standard
        ServicePack  : 1
        WindowsSN    : 00477-001-0000421-84672
        Model        : VMware Virtual Platform
        MACAddress   : 00:50:56:8A:66:A2
        IPAddress    : {10.16.243.198, 10.16.243.197, 10.16.243.196}
        CPUInfo      : Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz, Number of Processors: 4
        RAM          : 32 GB
        DriveInfo    : {@{Name=E:\; DriveType=FixedDisk; TotalSize=137 GB; UsedSpace=100 GB; FreeSpace=37 GB;
                         PercentUsed=73 %; Filesystem=NTFS; IsBootVolume=False; CompressedVolume=False;
                         ContainsPageFile=False}, @{Name=F:\; DriveType=FixedDisk; TotalSize=410 GB; UsedSpace=158 GB;
                         FreeSpace=252 GB; PercentUsed=39 %; Filesystem=NTFS; IsBootVolume=False;
                         CompressedVolume=False; ContainsPageFile=False},  @{Name=C:\; DriveType=FixedDisk;
                         TotalSize=160 GB; UsedSpace=131 GB; FreeSpace=29 GB; PercentUsed=82 %; Filesystem=NTFS;
                         IsBootVolume=True; CompressedVolume=False; ContainsPageFile=True}, @{Name=D:\;
                         DriveType=CD-Rom; TotalSize=; UsedSpace=; FreeSpace=; PercentUsed=; Filesystem=;
                         IsBootVolume=; CompressedVolume=; ContainsPageFile=}}
        LastBootTime : 4/20/2020 12:56:58 PM
        UpTime       : 17 Days, 2 Hours, 0 Minutes


    PS C:\> $foo.driveinfo | format-table

        Name DriveType TotalSize UsedSpace FreeSpace PercentUsed Filesystem IsBootVolume CompressedVolume ContainsPageFile
        ---- --------- --------- --------- --------- ----------- ---------- ------------ ---------------- ----------------
        E:\  FixedDisk 137 GB    100 GB    37 GB     73 %        NTFS              False            False            False
        F:\  FixedDisk 410 GB    158 GB    252 GB    39 %        NTFS              False            False            False
        C:\  FixedDisk 160 GB    131 GB    29 GB     82 %        NTFS               True            False             True
        D:\  CD-Rom

        This is a multi-part example that shows how to see the drive info in detail.

        The goal is to see the drive info but it is stored in a sub-array that doesn't format well in the initial output
        view. To get around this problem, the first query is run using Out-Variable FOO, which saves the returned data
        to a variable named FOO.

        Once the dat is saved to $FOO, a second query can be run by typing the variable name $FOO and the accessing
        the sub property called DriveInfo. This produced a formatted output of the drive information contained in the
        sub array


    .EXAMPLE

        Get-PCInfo -computername PRSCEFTP01, PRDUS4DC01

        Name         : PRSCEFTP01
        Domain       : aligntech.com
        Description  : eFTP.
        OS           : Microsoft Windows Server 2008 R2 Standard
        ServicePack  : 1
        WindowsSN    : 00477-001-0000421-84672
        Model        : VMware Virtual Platform
        MACAddress   : 00:50:56:8A:66:A2
        IPAddress    : {10.16.243.198, 10.16.243.197, 10.16.243.196}
        CPUInfo      : Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz, Number of Processors: 4
        RAM          : 32 GB
        DriveInfo    : {@{Name=E:\; DriveType=FixedDisk; TotalSize=137 GB; UsedSpace=100 GB; FreeSpace=37 GB;
                       PercentUsed=73 %; Filesystem=NTFS; IsBootVolume=False; CompressedVolume=False;
                       ContainsPageFile=False}, @{Name=F:\; DriveType=FixedDisk; TotalSize=410 GB; UsedSpace=158 GB;
                       FreeSpace=252 GB; PercentUsed=39 %; Filesystem=NTFS; IsBootVolume=False; CompressedVolume=False;
                       ContainsPageFile=False}, @{Name=C:\; DriveType=FixedDisk; TotalSize=160 GB; UsedSpace=131 GB;
                       FreeSpace=29 GB; PercentUsed=82 %; Filesystem=NTFS; IsBootVolume=True; CompressedVolume=False;
                       ContainsPageFile=True}, @{Name=D:\; DriveType=CD-Rom; TotalSize=; UsedSpace=; FreeSpace=;
                       PercentUsed=; Filesystem=; IsBootVolume=; CompressedVolume=; ContainsPageFile=}}
        LastBootTime : 4/20/2020 12:56:58 PM
        UpTime       : 17 Days, 1 Hours, 54 Minutes

        Name         : PRDUS4DC01
        Domain       : aligntech.com
        Description  :
        OS           : Microsoft Windows Server 2019 Standard
        ServicePack  : 0
        WindowsSN    : 00429-70000-00000-AA847
        Model        : VMware7,1
        MACAddress   : 00:50:56:8A:76:63
        IPAddress    : {10.110.10.10, fe80::ed82:56b9:4c79:bf17}
        CPUInfo      : Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz, Number of Processors: 1
        RAM          : 8 GB
        DriveInfo    : {@{Name=C:\; DriveType=FixedDisk; TotalSize=59 GB; UsedSpace=23 GB; FreeSpace=36 GB;
                       PercentUsed=40 %; Filesystem=NTFS; IsBootVolume=True;
                       CompressedVolume=False; ContainsPageFile=True}, @{Name=D:\; DriveType=CD-Rom; TotalSize=;
                       UsedSpace=; FreeSpace=; PercentUsed=; Filesystem=; IsBootVolume=; CompressedVolume=;
                       ContainsPageFile=}}
        LastBootTime : 5/4/2020 9:27:23 PM
        UpTime       : 2 Days, 17 Hours, 24 Minutes

        Returns info for two remote computers named PRSCEFTP01 & PRDUS4DC01

    .INPUTS
        ComputerName
        Accepts input from pipeline

    .OUTPUTS
        Output (if any)

    .NOTES
        NAME:           Get-PCInfo.ps1
        AUTHOR:         Mike Kanakos
        Date Created:   2020-04-29
    #>

    [CmdletBinding()]
    param (
        [Alias("Name","PC","Computer")]
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$ComputerName=$env:COMPUTERNAME
    )

    process {
        Foreach ($PC in $ComputerName){
            Write-Verbose "Testing that $PC is online"
            $online = Test-Connection -ComputerName $PC -Count 2 -Quiet
                if ($online -eq $true){
                    # Get Machine Info
                    $ComputerInfo = Get-CimInstance Win32_ComputerSystem -ComputerName $PC
                    $OSInfo = Get-CimInstance Win32_OperatingSystem -ComputerName $PC
                    $BIOSInfo = Get-CimInstance Win32_BIOS -ComputerName $PC
                    $CPUInfo = Get-CimInstance Win32_Processor -ComputerName $PC
                    $CPUName = $CPUInfo | select-object -ExpandProperty Name -Unique
                    $CPUCount = $CPUInfo.count
                    $DriveInfo = Get-DriveInfo -computername $PC
                    $LastBootTime = $OSInfo.LastBootUpTime
                    $Uptime = (New-TimeSpan -start $lastBoottime -end (Get-Date))
                    $Days = $uptime.days
                    $Minutes = $uptime.Minutes
                    $Hours = $uptime.hours
                    $MacAddress = (get-ciminstance win32_networkadapterConfiguration -Filter "ipenabled='True'" -ComputerName $PC | Select-Object macaddress).Macaddress
                    $IPAddress = Get-CimInstance win32_networkadapterconfiguration -ComputerName $PC | Where-Object {$_.IPAddress -ne $null} | Select-Object -ExpandProperty IPAddress

                    $Info = [PSCustomObject]@{
                        Name = $ComputerInfo.Name
                        Domain = $ComputerInfo.Domain
                        Description = (Get-ADComputer $PC -Properties Description | Select-Object  Description -ExpandProperty description)
                        OS = $OSInfo.Caption
                        ServicePack = $OSInfo.servicepackmajorversion
                        WindowsSN = $OSInfo.SerialNumber
                        Model = $ComputerInfo.Model
                        MACAddress = $MacAddress
                        IPAddress = $IPAddress
                        CPUInfo = "$CPUName, Number of Processors: $CPUCount"
                        RAM = "$([math]::round($ComputerInfo.TotalPhysicalMemory/1gb)) GB"
                        DriveInfo = $DriveInfo
                        LastBootTime = $LastBootTime
                        UpTime = "$Days Days, $hours Hours, $Minutes Minutes"
                    } #end Info object creation

                    $Info
                } #end if

                else {
                     Write-Warning "The computer $(($computer).ToUpper()) could not be contacted"
                    }
        }  #end foreach

    }#end process block

} #end