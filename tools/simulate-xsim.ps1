$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$buildRoot = Join-Path $projectRoot 'build\sim'
$waveOutput = Join-Path $buildRoot 'wave.vcd'
$vivadoBin = 'C:\AMDDesignTools\2026.1\Vivado\bin'
$compiler = Join-Path $vivadoBin 'xvlog.bat'
$elaborator = Join-Path $vivadoBin 'xelab.bat'
$simulator = Join-Path $vivadoBin 'xsim.bat'
$runRoot = Join-Path $buildRoot ('run-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $runRoot -Force | Out-Null
if (Test-Path -LiteralPath $waveOutput) { Remove-Item -LiteralPath $waveOutput }
$sources = @((Join-Path $projectRoot 'src\compare_4.v'), (Join-Path $projectRoot 'sim\tb_compare_4.sv'))
Push-Location -LiteralPath $runRoot
try {
    & $compiler --sv @sources *> compile.log
    if ($LASTEXITCODE -ne 0) { Get-Content compile.log; throw 'Compile failed.' }
    & $elaborator tb_compare_4 --debug typical --snapshot compare_4_sim *> elaborate.log
    if ($LASTEXITCODE -ne 0) { Get-Content elaborate.log; throw 'Elaboration failed.' }
    & $simulator compare_4_sim --runall *> simulation.log
    $simExit = $LASTEXITCODE
    Get-Content simulation.log
    if ($simExit -ne 0) { throw 'Simulation failed.' }
    if (-not (Select-String -LiteralPath simulation.log -SimpleMatch 'LAB1_PASS compare_4 cases=256' -Quiet)) { throw 'The testbench did not report all 256 cases passing.' }
    if (-not (Test-Path -LiteralPath 'wave.vcd')) { throw 'No VCD was generated.' }
    Copy-Item -LiteralPath 'wave.vcd' -Destination $waveOutput
    Write-Host 'SIMULATED: LAB1_PASS compare_4 cases=256'
    Write-Host "Waveform: $waveOutput"
    Write-Host "Logs: $runRoot"
} finally { Pop-Location }
