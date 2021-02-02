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