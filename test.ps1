#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

function __exec($_cmd) {
  & $_cmd @args
  if ($LASTEXITCODE -ne 0) {
    throw "$cmd exited with $LASTEXITCODE"
  }
}

$tmpDir = "$PSScriptRoot/.build/test-template/"
$toolsDir = Join-Path ${home} (Join-Path '.dotnet' 'tools')

if (-not ($env:PATH -contains $toolsDir)) {
  $pathSeparator = if ($IsWindows -or -not $IsCoreCLR) { ';'} else { ': '}
  $env:PATH = "${toolsDir}${pathSeparator}${env:PATH}"
}

Remove-Item -Recurse .build/test-template/ -ErrorAction Ignore
Remove-Item -Recurse .build/bin/test-template/ -ErrorAction Ignore
Remove-Item -Recurse $home/.dotnet/toolspkgs/test-template/ -ErrorAction Ignore
Get-ChildItem "$toolsDir/test-template*" -ErrorAction Ignore | Remove-Item

& "$PSScriptRoot/build.ps1" -Version 99.99.99 -OutputDir $tmpDir
__exec dotnet new --debug:custom-hive "$tmpDir/templateengine" --install $tmpDir/McMaster.DotNet.GlobalTool.Templates.99.99.99.nupkg
__exec dotnet new global-tool --debug:custom-hive "$tmpDir/templateengine" --output $tmpDir --command-name test-template
__exec dotnet pack $tmpDir --output $tmpDir
__exec dotnet tool install -g test-template --source-feed $tmpDir --version 1.0.0

Get-Command test-template

__exec test-template --help
__exec test-template --name 'test script'

