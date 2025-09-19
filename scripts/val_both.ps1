$ErrorActionPreference = 'Stop'
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Activate = Join-Path $RepoRoot 'weapon-det-env\Scripts\Activate.ps1'
if (!(Test-Path $Activate)) { throw "Не найден: $Activate" }
if ((Get-ExecutionPolicy) -eq 'Restricted') { Set-ExecutionPolicy Bypass -Scope Process -Force }
& $Activate

$cfg1 = Join-Path $RepoRoot 'configs\val\val_before.yaml'
$cfg2 = Join-Path $RepoRoot 'configs\val\val_after.yaml'
if (!(Test-Path $cfg1)) { throw "Нет конфига: $cfg1" }
if (!(Test-Path $cfg2)) { throw "Нет конфига: $cfg2" }

$run1 = Join-Path $RepoRoot 'runs\compare\before_knife_boost_val'
$run2 = Join-Path $RepoRoot 'runs\compare\after_knife_boost_val'
foreach ($p in @($run1,$run2)) { if (Test-Path $p) { Remove-Item $p -Recurse -Force } }

yolo val cfg="$cfg1"
yolo val cfg="$cfg2"

Write-Host "Готово: сравнение сохранено в runs\compare\*_val" -ForegroundColor Green
