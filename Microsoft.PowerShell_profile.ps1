Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\catppuccin_macchiato.omp.json" | Invoke-Expression

Import-Module -Name Microsoft.WinGet.CommandNotFound

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Key Tab -Function Complete

function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

Set-PSReadLineKeyHandler -Key "Ctrl+o" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("yy")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module -Name Terminal-Icons
