# Hash Manifest Generator v0.9.0

This is a pre-1.0 GitHub release candidate for Hash Manifest Generator.

## Release Status

This is a public pre-release build.

The application is not currently Microsoft code signed. Windows SmartScreen or antivirus tools may warn when opening the executable.

## Highlights

- Generate file-level hash manifests
- Verify current files against a prior manifest
- Compare two saved manifest JSON files
- Export TXT, CSV, DOCX, XLSX, and JSON reports
- Optional report signature block
- Agency, unit, technician, output folder, and branding settings
- Dark and light themes
- Windows EXE packaging support
- SHA-256 checksums generated for release files

## Output Formats

Normal manifest export creates:

- TXT
- CSV
- DOCX
- XLSX
- JSON

Verification export creates:

- TXT
- CSV
- DOCX
- XLSX
- JSON

Compare export creates:

- TXT
- CSV
- DOCX
- XLSX
- JSON

## Verification Mode

Verification Mode allows a user to load a prior JSON manifest, hash current files, and compare the current hash values against the prior manifest.

Possible verification results include:

- Matched
- Hash mismatch
- Missing from current selection
- New file not in original manifest
- Error

## Compare Mode

Compare Mode allows a user to compare two saved JSON manifests without re-hashing current files.

Possible compare results include:

- Matched
- Hash mismatch
- Only in Manifest A
- Only in Manifest B
- Error

## Important Limitations

Hash Manifest Generator is not a forensic imaging tool.

It does not create E01, AFF4, RAW/DD, logical, or physical forensic images.

It performs file-level hashing and report generation only.

## Unsigned Build Notice

This release is unsigned.

Users may see a Windows SmartScreen warning because the executable is not code signed.

The maintainer intends to evaluate Microsoft code signing options before a future v1.0 release.

## Checksums

SHA-256 checksums are included with the release.

Users should download release files only from the official GitHub repository.