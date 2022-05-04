
#region - current view of files
get-childitem C:\demofolder
#endregion

#region - enable the file info styles
Enable-ExperimentalFeature PSANSIRenderingFileInfo
#mention restart session (already done)

#endregion

#region - show the pstyle current setting
$psstyle.FileInfo

#endregion

#region - change color for PS1 extension
$psstyle.FileInfo.Extension[".ps1"] = $psstyle.foreground.blue

dir C:\demofolder

#endregion

#region - add a new extension to the list
$PSStyle.FileInfo.Extension.add(".docx", $psstyle.Foreground.Green)
$PSStyle.FileInfo.Extension.add(".xlsx", $psstyle.Foreground.Green)
$PSStyle.FileInfo.Extension.add(".zip", $psstyle.Foreground.BrightRed)
$PSStyle.FileInfo.Extension.add(".7z", $psstyle.Foreground.BrightRed)
$PSStyle.FileInfo.Extension.add(".csv", $psstyle.Foreground.BrightMagenta)
$PSStyle.FileInfo.Extension.add(".png", $psstyle.Foreground.Cyan)
$PSStyle.FileInfo.Extension.add(".jpg", $psstyle.Foreground.Cyan)
$PSStyle.FileInfo.Extension.add(".gif", $psstyle.Foreground.Cyan)
$PSStyle.FileInfo.Extension.add(".pdf", $psstyle.Foreground.BrightYellow)

#endregion

#region - display the results
Get-ChildItem C:\demofolder | Sort-Object Extension

#endregion


#region - reset colors
$extensions = ".gif",".zip",".png",".jpg",".jpeg", ".ps1",".csv",".xlsx",".docx",".csv",".pdf"
Foreach ($e in $extensions){$psstyle.FileInfo.extension["$e"] = $psstyle.Foreground.BrightWhite}

$psstyle.FileInfo.extension[".ps1"] = $psstyle.Foreground.BrightWhite
$psstyle.FileInfo.extension[".zip"] = $psstyle.Foreground.BrightWhite
$psstyle.FileInfo.extension[".*"] = $psstyle.Foreground.BrightWhite

$PSStyle.FileInfo.Extension.remove(".docx")
$PSStyle.FileInfo.Extension.remove(".doc")
$PSStyle.FileInfo.Extension.remove(".xlsx")
$PSStyle.FileInfo.Extension.remove(".zip")
$PSStyle.FileInfo.Extension.remove(".7z")
$PSStyle.FileInfo.Extension.remove(".csv")
$PSStyle.FileInfo.Extension.remove(".png")
$PSStyle.FileInfo.Extension.remove(".jpg")
$PSStyle.FileInfo.Extension.remove(".gif")
$PSstyle.FileInfo.Extension.remove(".jpeg")
$PSStyle.FileInfo.Extension.remove(".pdf")
#endregion
