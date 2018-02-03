#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$tmpDir = "$PSScriptRoot/.build/test-template/"

& dotnet new --uninstall McMaster.DotNet.GlobalTool.Templates | out-null
Remove-Item -Recurse .build/test-template/ -ErrorAction Ignore
Get-ChildItem "${home}/.dotnet/tools/test-template*" -ErrorAction Ignore | Remove-Item

& "$PSScriptRoot/build.ps1"
& dotnet new --install $PSScriptRoot/artifacts/McMaster.DotNet.GlobalTool.Templates.99.99.99.nupkg
& dotnet new global-tool --output $tmpDir --command-name test-template
& dotnet pack $tmpDir --output $tmpDir
& dotnet install tool -g test-template --source $tmpDir --version 1.0.0

Get-Command test-template

& test-template

if ($LASTEXITCODE -ne 0) {
  Write-Error "Template test faile"
  exit 1
}
