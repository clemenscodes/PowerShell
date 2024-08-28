Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\catppuccin_macchiato.omp.json" | Invoke-Expression

Import-Module -Name Microsoft.WinGet.CommandNotFound

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Key Tab -Function Complete

function yazicd {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

function rr {
    yazicd $env:USERPROFILE\.local\src
}

function ne {
    yazicd $env:MOON
}

Set-PSReadLineKeyHandler -Key "Ctrl+o" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("yazicd")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module -Name Terminal-Icons
Import-Module git-aliases -DisableNameChecking

Import-Module -Name "C:\Users\clay\moon.ps1"
Import-Module -Name "C:\Users\clay\proto.ps1"

# proto
$env:PROTO_HOME = Join-Path $HOME ".proto";
$env:PATH = @(
  (Join-Path $env:PROTO_HOME "shims")
  (Join-Path $env:PROTO_HOME "bin")
  $env:PATH
) -join [IO.PATH]::PathSeparator;
