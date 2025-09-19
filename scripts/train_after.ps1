$ErrorActionPreference = 'Stop'
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Activate = Join-Path $RepoRoot 'weapon-det-env\Scripts\Activate.ps1'
if (!(Test-Path $Activate)) { throw "Не найден: $Activate" }
if ((Get-ExecutionPolicy) -eq 'Restricted') { Set-ExecutionPolicy Bypass -Scope Process -Force }
& $Activate

$cfg = Join-Path $RepoRoot 'configs\train\train_after.yaml'
if (!(Test-Path $cfg)) { throw "Нет конфига: $cfg" }

yolo train cfg="$cfg"
