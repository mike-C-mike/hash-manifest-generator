# Dependencies

Hash Manifest Generator is built with Python and Tkinter.

## Runtime Dependencies

### Python Standard Library

The application uses the Python standard library for:

- File and folder handling
- JSON export
- CSV export
- Hash calculation through `hashlib`
- Date and time handling
- Threading and queue handling
- Tkinter GUI components

Python is distributed under the Python Software Foundation License.

### python-docx

Purpose: DOCX report generation.

License: MIT.

Use in this project:

- Creates DOCX hash manifest reports
- Creates DOCX verification reports
- Creates DOCX compare reports
- Inserts optional report branding images when configured

### openpyxl

Purpose: XLSX workbook generation.

License: MIT.

Use in this project:

- Creates XLSX hash manifest workbooks
- Creates XLSX verification workbooks
- Creates XLSX compare workbooks
- Provides formatted worksheets, filters, frozen panes, and summary sheets

## Build Dependencies

### PyInstaller

Purpose: Windows executable packaging.

License: GPL 2.0 with a special exception allowing use to build commercial or non-free programs.

Use in this project:

- Packages the Python application into a Windows executable
- Used only for release builds

PyInstaller is not used by the application at runtime when running from source.

## Current Dependency Summary

| Dependency | Purpose | License | Runtime |
|---|---|---:|---:|
| Python Standard Library | Core application logic | PSF License | Yes |
| Tkinter | GUI | Tcl/Tk/Python distribution dependent | Yes |
| python-docx | DOCX output | MIT | Yes |
| openpyxl | XLSX output | MIT | Yes |
| PyInstaller | Windows packaging | GPL 2.0 with exception | Build only |

## Dependency Policy

This project should avoid new dependencies unless they provide clear value.

Preferred licenses:

- MIT
- BSD
- Apache 2.0
- PSF
- Public domain / Unlicense when appropriate

Dependencies that require extra review before use:

- GPL
- LGPL
- AGPL
- Non-commercial licenses
- Source-available but not open-source licenses
- Unknown or custom licenses
- Commercial SDKs