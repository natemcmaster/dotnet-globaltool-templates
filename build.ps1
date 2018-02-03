#!/usr/bin/env pwsh
param(
    [Parameter()]
    [string]$Version = '99.99.99',
    [Parameter()]
    [string]$OutputDir = "$PSScriptRoot/artifacts"
)

$ErrorActionPreference = 'Stop'

$buildDir = "$PSScriptRoot/.build"
New-Item $buildDir -Type Directory -ErrorAction SilentlyContinue
New-Item $OutputDir -Type Directory -ErrorAction SilentlyContinue

if ($IsMacOS -or $IsLinux) {
    # relies on Mono to be installed
    $nugetPath = 'nuget'
}
else {
    $nugetPath = "$buildDir/nuget.exe"
    if (-not (Test-Path $nugetPath)) {
        Invoke-WebRequest https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile $nugetPath
    }
}

& $nugetPath pack `
    "$PSScriptRoot/src/McMaster.DotNet.GlobalTool.Templates/McMaster.DotNet.GlobalTool.Templates.nuspec" `
    -Version $Version `
    -OutputDirectory $OutputDir
