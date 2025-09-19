$ErrorActionPreference = 'Stop'
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Activate = Join-Path $RepoRoot 'weapon-det-env\Scripts\Activate.ps1'
if (!(Test-Path $Activate)) { throw "Не найден: $Activate" }
if ((Get-ExecutionPolicy) -eq 'Restricted') { Set-ExecutionPolicy Bypass -Scope Process -Force }
& $Activate

$cfg = Join-Path $RepoRoot 'configs\val\val_before.yaml'
if (!(Test-Path $cfg)) { throw "Нет конфига: $cfg" }

$run = Join-Path $RepoRoot 'runs\compare\before_knife_boost_val'
if (Test-Path $run) { Remove-Item $run -Recurse -Force }

yolo val cfg="$cfg"
Write-Host "Готово: $run" -ForegroundColor Green
