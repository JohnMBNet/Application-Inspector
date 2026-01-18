# Application Inspector

A PowerShell-based application inspector with a modern web interface. Search, view, and analyze installed applications on your Windows system with deep registry introspection.

![PowerShell](https://img.shields.io/badge/PowerShell-7.0+-5391FE?style=flat-square&logo=powershell&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Windows-0078D6?style=flat-square&logo=windows&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

## Features

- **Modern Dark UI** - Material Design + Bootflat inspired dark theme
- **Deep Registry Analysis** - Extracts comprehensive data from Windows registry
- **Application Icons** - Displays actual application icons extracted from executables
- **Uninstall Commands** - Copy-ready uninstall command lines (standard and silent)
- **Smart Filtering** - Filter by System/User installs, 32-bit/64-bit architecture
- **Export Options** - Export to JSON, CSV, or clipboard
- **Real-time Search** - Search by application name or publisher
- **Zero Dependencies** - Pure PowerShell with embedded web frontend

## Screenshots

The interface features a gradient header, statistics dashboard, and detailed application cards with expandable registry information.

## Requirements

- Windows 10/11
- PowerShell 7.0 or higher

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/JohnMBNet/application-inspector.git
   ```

2. Navigate to the directory:
   ```bash
   cd application-inspector
   ```

## Usage

Run the script:
```powershell
.\AppInspector.ps1 -port 8095
```

Then open your browser to `http://localhost:8095`.

## Features in Detail

### Application Data Retrieved

| Field | Description |
|-------|-------------|
| Name | Application display name |
| Version | Installed version |
| Publisher | Software publisher |
| Install Date | When the application was installed |
| Install Location | Installation directory path |
| Estimated Size | Disk space used |
| Architecture | 32-bit (x86) or 64-bit (x64) |
| Scope | System-wide or User install |
| Installed By | User/Administrator who installed |
| Uninstall String | Command to uninstall |
| Silent Uninstall | Quiet uninstall command |
| Registry Path | Full registry key location |
| All Registry Data | Complete registry entries |

### Filtering Options

- **All** - Show all applications
- **System-wide** - Applications installed for all users (HKLM)
- **User Only** - Applications installed for current user (HKCU)
- **64-bit** - Native 64-bit applications
- **32-bit** - 32-bit/WOW64 applications

### Export Formats

- **JSON** - Complete data with all registry details
- **CSV** - Spreadsheet-compatible format
- **Clipboard** - Quick copy for pasting

## API Endpoints

The embedded web server exposes the following endpoints:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Web interface |
| `/api/search?q=term` | GET | Search applications |
| `/api/all` | GET | List all applications |
| `/api/icon?path=...` | GET | Get application icon |

## Architecture

```
AppInspector.ps1
├── Embedded HTML/CSS/JS Frontend
│   ├── Material Design Dark Theme
│   ├── Responsive Grid Layout
│   └── Async Icon Loading
├── HttpListener Web Server
├── Registry Scanner
│   ├── HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
│   ├── HKLM:\SOFTWARE\WOW6432Node\...\Uninstall
│   └── HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
└── Icon Extractor (System.Drawing)
```

## Author

**John Booth**

Built with assistance from Claude Opus (Anthropic)

## License

MIT License - See [LICENSE](LICENSE) for details.

## Acknowledgments

- Anthoopic Claude Opus
- Material Design color palette and principles
- Bootflat UI framework inspiration
- Font Awesome icons
- Google Roboto font family
