param (
    [string]$fontPath
)

# $FontPath = "C:\Users\Dominik\Desktop\SANDBOX\BigBlueTermPlusNerdFont-Regular.ttf"
$ShellApp = New-Object -ComObject Shell.Application
$FontFile = Get-Item $fontPath

# Check if already installed
if (-not (Test-Path "C:\Windows\Fonts\$($FontFile.Name)")) {
    $FontsFolder = $ShellApp.Namespace(0x14)  # 0x14 = Fonts folder const
    $FontsFolder.CopyHere($fontPath)
    Write-Output "$($FontFile.Name) installed via shell context"
} else {
    Write-Output "Font already exists in system directory"
}