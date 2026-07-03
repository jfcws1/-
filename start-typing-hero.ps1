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

Start-Process -FilePath $edge -ArgumentList @(
  '--app=' + $url,
  '--user-data-dir=' + $profile,
  '--window-size=1200,760'
)
