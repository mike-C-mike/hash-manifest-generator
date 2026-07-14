# Hash Manifest Generator Release Build Script
# Run from the project root.

param(
    [string]$Version = "0.9.0"
)

$ErrorActionPreference = "Stop"

$AppName = "HashManifestGenerator"
$ExeName = "$AppName.exe"

$ReleaseRoot = "release"
$DistRoot = "dist"
$BuildRoot = "build"
$ReleaseFolder = Join-Path $ReleaseRoot "$AppName-v$Version"
$ZipPath = Join-Path $ReleaseRoot "$AppName-v$Version.zip"
$ChecksumPath = Join-Path $ReleaseRoot "$AppName-v$Version-SHA256SUMS.txt"

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

if (Test-Path $ChecksumPath) {
    Remove-Item $ChecksumPath -Force
}

New-Item -ItemType Directory -Path $ReleaseFolder | Out-Null

Write-Host "`nInstalling runtime requirements..." -ForegroundColor Yellow
py -m pip install -r requirements.txt

Write-Host "`nInstalling build requirements..." -ForegroundColor Yellow
py -m pip install -r requirements-build.txt

Write-Host "`nRunning PyInstaller..." -ForegroundColor Yellow
py -m PyInstaller .\HashManifestGenerator.spec --clean --noconfirm

$ExePath = Join-Path $DistRoot $ExeName

if (!(Test-Path $ExePath)) {
    throw "Expected executable was not created: $ExePath"
}

Write-Host "`nCopying release files..." -ForegroundColor Yellow

Copy-Item $ExePath $ReleaseFolder

$DocsToCopy = @(
    "README.md",
    "BUILD.md",
    "DEPENDENCIES.md",
    "KNOWN_LIMITATIONS.md",
    "RELEASE_CHECKLIST.md",
    "RELEASE_NOTES.md",
    "UNSIGNED_WINDOWS_NOTICE.md",
    "settings.example.json",
    "LICENSE"
)

foreach ($Doc in $DocsToCopy) {
    if (Test-Path ".\$Doc") {
        Copy-Item ".\$Doc" $ReleaseFolder
    }
}

if (!(Test-Path (Join-Path $ReleaseFolder "output"))) {
    New-Item -ItemType Directory -Path (Join-Path $ReleaseFolder "output") | Out-Null
}

if (!(Test-Path (Join-Path $ReleaseFolder "saved_manifests"))) {
    New-Item -ItemType Directory -Path (Join-Path $ReleaseFolder "saved_manifests") | Out-Null
}

Write-Host "`nCreating ZIP..." -ForegroundColor Yellow
Compress-Archive -Path "$ReleaseFolder\*" -DestinationPath $ZipPath -Force

Write-Host "`nCreating SHA-256 checksums..." -ForegroundColor Yellow

$ReleaseExePath = Join-Path $ReleaseFolder $ExeName

$ExeHash = Get-FileHash -Path $ReleaseExePath -Algorithm SHA256
$ZipHash = Get-FileHash -Path $ZipPath -Algorithm SHA256

$ChecksumLines = @(
    "# Hash Manifest Generator v$Version SHA-256 Checksums",
    "",
    "$($ExeHash.Hash)  $ExeName",
    "$($ZipHash.Hash)  $AppName-v$Version.zip"
)

$ChecksumLines | Set-Content -Path $ChecksumPath -Encoding UTF8
Copy-Item $ChecksumPath $ReleaseFolder

Write-Host "`nRelease build complete." -ForegroundColor Green
Write-Host "Folder:    $ReleaseFolder"
Write-Host "ZIP:       $ZipPath"
Write-Host "Checksums: $ChecksumPath"