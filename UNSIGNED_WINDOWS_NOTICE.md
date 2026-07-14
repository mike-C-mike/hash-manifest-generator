# Unsigned Windows Build Notice

Hash Manifest Generator releases are currently unsigned Windows builds.

This means Windows SmartScreen or antivirus products may display a warning when the application is downloaded or opened.

## Why this happens

Windows commonly warns about new or unsigned executable files, especially when they are newly published and have not yet built reputation.

## Current status

This build is not Microsoft code signed.

The project maintainer intends to evaluate Microsoft code signing options before publishing a future v1.0 release.

## What users can verify

Users can verify the release ZIP or executable with the published SHA-256 checksums included with the release.

## What this notice does not mean

This notice does not mean the application is malware.

It means the executable has not been signed with a trusted code signing certificate.

## Recommended user action

Only download releases from the official GitHub repository.

Do not download the executable from third-party mirrors or reposted links.