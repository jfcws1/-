$ErrorActionPreference = 'Stop'

$edge = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
if (-not (Test-Path $edge)) {
  $edge = 'C:\Program Files\Microsoft\Edge\Application\msedge.exe'
}

if (-not (Test-Path $edge)) {
  throw 'Microsoft Edge was not found on this computer.'
}

$appDir = Split-Path -Parent $PSCommandPath
$html = Join-Path $appDir 'typing-hero.html'
$profile = Join-Path $appDir '.edge-profile-typing'
$url = [System.Uri]::new((Resolve-Path $html).Path).AbsoluteUri

$profileMarker = [Regex]::Escape($profile)
$running = Get-CimInstance Win32_Process -Filter "Name = 'msedge.exe'" |
  Where-Object { $_.CommandLine -match $profileMarker -and $_.CommandLine -match '--app=' }

if ($running) {
  try {
    $shell = New-Object -ComObject WScript.Shell
    if ($shell.AppActivate('键道')) {
      Start-Sleep -Milliseconds 150
      $shell.SendKeys('{F5}')
    }
  } catch {
    # If focusing fails, keep the existing single window and avoid opening another.
  }
  exit 0
}

Start-Process -FilePath $edge -ArgumentList @(
  '--app=' + $url,
  '--user-data-dir=' + $profile,
  '--window-size=1200,760'
)
