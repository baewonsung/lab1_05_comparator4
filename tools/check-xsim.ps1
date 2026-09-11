$ErrorActionPreference = 'Stop'
$vivadoBin = 'C:\AMDDesignTools\2026.1\Vivado\bin'
foreach ($name in @('xvlog', 'xelab', 'xsim')) {
    $tool = Join-Path $vivadoBin ($name + '.bat')
    if (-not (Test-Path -LiteralPath $tool)) { throw "$name was not found at $tool" }
    Write-Host "$name : $tool"
    & $tool -version
    if ($LASTEXITCODE -ne 0) { throw "$name version check failed" }
}
Write-Host 'PASS: Vivado XSim tools are available.'
