param (
    [string]$fontPath
)

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

# Get the font name from .ttf file
Add-Type -AssemblyName PresentationCore
$glyphTypeface = New-Object Windows.Media.GlyphTypeface $fontPath
$fontName = $glyphTypeface.Win32FamilyNames.Values
return $fontName