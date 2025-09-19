$ErrorActionPreference = 'Stop'

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Activate = Join-Path $RepoRoot 'weapon-det-env\Scripts\Activate.ps1'
if (!(Test-Path $Activate)) { throw "Не найден venv-активатор: $Activate" }
if ((Get-ExecutionPolicy) -eq 'Restricted') { Set-ExecutionPolicy Bypass -Scope Process -Force }
& $Activate

$cfg = Join-Path $RepoRoot 'configs\predict\predict_before_knife.yaml'
if (!(Test-Path $cfg)) { throw "Нет конфига: $cfg" }

$outDir = Join-Path $RepoRoot 'runs\demo\before_knife_boost_knife_demo'
if (Test-Path $outDir) { Remove-Item $outDir -Recurse -Force -ErrorAction SilentlyContinue }

yolo predict cfg="$cfg"
Write-Host "Готово: $outDir" -ForegroundColor Green
