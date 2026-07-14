# Hash Manifest Generator Release Build Script
# Run from the project root.

param(
    [string]$Version = "0.8.0"
)

$ErrorActionPreference = "Stop"

$AppName = "HashManifestGenerator"
$ReleaseRoot = "release"
$DistRoot = "dist"
$BuildRoot = "build"
$ReleaseFolder = Join-Path $ReleaseRoot "$AppName-v$Version"
$ZipPath = Join-Path $ReleaseRoot "$AppName-v$Version.zip"

Write-Host "Hash Manifest Generator release build" -ForegroundColor Cyan
Write-Host "Version: $Version" -ForegroundColor Cyan

Write-Host "`nCleaning old build folders..." -ForegroundColor Yellow

if (Test-Path $DistRoot) {
    Remove-Item $DistRoot -Recurse -Force
}

if (Test-Path $BuildRoot) {
    Remove-Item $BuildRoot -Recurse -Force
}

if (Test-Path $ReleaseFolder) {
    Remove-Item $ReleaseFolder -Recurse -Force
}

if (Test-Path $ZipPath) {
    Remove-Item $ZipPath -Force
}

New-Item -ItemType Directory -Path $ReleaseFolder | Out-Null

Write-Host "`nInstalling runtime requirements..." -ForegroundColor Yellow
py -m pip install -r requirements.txt

Write-Host "`nInstalling build requirements..." -ForegroundColor Yellow
py -m pip install -r requirements-build.txt

Write-Host "`nRunning PyInstaller..." -ForegroundColor Yellow
py -m PyInstaller .\HashManifestGenerator.spec --clean --noconfirm

$ExePath = Join-Path $DistRoot "$AppName.exe"

if (!(Test-Path $ExePath)) {
    throw "Expected executable was not created: $ExePath"
}

Write-Host "`nCopying release files..." -ForegroundColor Yellow

Copy-Item $ExePath $ReleaseFolder

if (Test-Path ".\settings.example.json") {
    Copy-Item ".\settings.example.json" $ReleaseFolder
}

if (Test-Path ".\README.md") {
    Copy-Item ".\README.md" $ReleaseFolder
}

if (Test-Path ".\DEPENDENCIES.md") {
    Copy-Item ".\DEPENDENCIES.md" $ReleaseFolder
}

if (Test-Path ".\KNOWN_LIMITATIONS.md") {
    Copy-Item ".\KNOWN_LIMITATIONS.md" $ReleaseFolder
}

if (!(Test-Path (Join-Path $ReleaseFolder "output"))) {
    New-Item -ItemType Directory -Path (Join-Path $ReleaseFolder "output") | Out-Null
}

if (!(Test-Path (Join-Path $ReleaseFolder "saved_manifests"))) {
    New-Item -ItemType Directory -Path (Join-Path $ReleaseFolder "saved_manifests") | Out-Null
}

Write-Host "`nCreating ZIP..." -ForegroundColor Yellow
Compress-Archive -Path "$ReleaseFolder\*" -DestinationPath $ZipPath -Force

Write-Host "`nRelease build complete." -ForegroundColor Green
Write-Host "Folder: $ReleaseFolder"
Write-Host "ZIP:    $ZipPath"