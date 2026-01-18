<div align="center">

```
     _                ___                           _
    / \   _ __  _ __ |_ _|_ __  ___ _ __   ___  ___| |_ ___  _ __
   / _ \ | '_ \| '_ \ | || '_ \/ __| '_ \ / _ \/ __| __/ _ \| '__|
  / ___ \| |_) | |_) || || | | \__ \ |_) |  __/ (__| || (_) | |
 /_/   \_\ .__/| .__/|___|_| |_|___/ .__/ \___|\___|\__\___/|_|
         |_|   |_|                 |_|
```

# Application Inspector

### *Peer into the soul of your Windows system*

<br>

[![PowerShell](https://img.shields.io/badge/PowerShell-7.0+-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-MIT-22c55e?style=for-the-badge)](LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-Yes-22c55e?style=for-the-badge)](https://github.com/JohnMBNet/application-inspector)

<br>

**A stunning PowerShell-based application inspector with a modern web interface.**
**Search, view, and analyze installed applications with deep registry introspection.**

<br>

[**Get Started**](#-quick-start) · [**Features**](#-features) · [**Screenshots**](#-interface-preview) · [**API**](#-api-reference)

---

</div>

<br>

## Why Application Inspector?

<table>
<tr>
<td width="50%">

### The Problem

Ever tried to find what's *really* installed on a Windows machine? The Control Panel lies. Settings app hides things. WMI is slow and incomplete.

The registry holds the truth—but who wants to dig through that maze?

</td>
<td width="50%">

### The Solution

**Application Inspector** surgically extracts every installed application from the Windows registry and presents it through a beautiful, searchable web interface.

*One script. Zero dependencies. Complete visibility.*

</td>
</tr>
</table>

<br>

## ✨ Features

<div align="center">

|  |  |  |
|:---:|:---:|:---:|
| **Modern Dark UI** | **Deep Registry Analysis** | **Application Icons** |
| Material Design + Bootflat inspired | Comprehensive HKLM/HKCU extraction | Live icons from executables |
| dark theme that's easy on the eyes | with complete registry data exposure | displayed right in the interface |
|  |  |  |
| **Smart Filtering** | **Export Anywhere** | **Zero Dependencies** |
| System/User installs | JSON, CSV, or Clipboard | Pure PowerShell with |
| 32-bit/64-bit architecture | with one click | embedded web frontend |

</div>

<br>

<details>
<summary><b>📋 Complete Data Retrieved</b> — Click to expand</summary>

<br>

| Field | Description |
|:------|:------------|
| `Name` | Application display name |
| `Version` | Currently installed version |
| `Publisher` | Software publisher/vendor |
| `Install Date` | When the application was installed |
| `Install Location` | Full installation directory path |
| `Estimated Size` | Disk space consumed |
| `Architecture` | 32-bit (x86) or 64-bit (x64) |
| `Scope` | System-wide or per-user install |
| `Installed By` | User/Administrator who performed install |
| `Uninstall String` | Standard uninstall command |
| `Silent Uninstall` | Quiet/automated uninstall command |
| `Registry Path` | Full registry key location |
| `All Registry Data` | Complete raw registry entries |

</details>

<br>

---

<br>

## 🚀 Quick Start

```powershell
# Clone the repository
git clone https://github.com/JohnMBNet/application-inspector.git

# Navigate to directory
cd application-inspector

# Launch the inspector
.\AppInspector.ps1 -port 8095
```

Then open your browser to **`http://localhost:8095`** and explore.

<br>

> **Note**
> Requires Windows 10/11 and PowerShell 7.0 or higher.

<br>

---

<br>

## 🎨 Interface Preview

<div align="center">

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│   ╔═══════════════════════════════════════════════════════════════════╗    │
│   ║              🔍 APPLICATION INSPECTOR                             ║    │
│   ║                                                                   ║    │
│   ║    ┌─────────────────────────────────────────────────────────┐   ║    │
│   ║    │  🔎 Search applications...                              │   ║    │
│   ║    └─────────────────────────────────────────────────────────┘   ║    │
│   ║                                                                   ║    │
│   ║    [All] [System] [User] [64-bit] [32-bit]   📤 Export ▼        ║    │
│   ║                                                                   ║    │
│   ╠═══════════════════════════════════════════════════════════════════╣    │
│   ║                                                                   ║    │
│   ║   ┌─────────────────────────────────────────────────────────┐    ║    │
│   ║   │  📦 Visual Studio Code                         v1.85.0 │    ║    │
│   ║   │  Microsoft Corporation              ░░░░░░░░░░  245 MB │    ║    │
│   ║   │  ────────────────────────────────────────────────────── │    ║    │
│   ║   │  📍 C:\Program Files\Microsoft VS Code                  │    ║    │
│   ║   │  🏛️ System-wide  •  🖥️ 64-bit  •  📅 2024-01-15       │    ║    │
│   ║   └─────────────────────────────────────────────────────────┘    ║    │
│   ║                                                                   ║    │
│   ║   ┌─────────────────────────────────────────────────────────┐    ║    │
│   ║   │  📦 Node.js                                   v20.10.0 │    ║    │
│   ║   │  Node.js Foundation                 ░░░░░░░░░░   78 MB │    ║    │
│   ║   │  ────────────────────────────────────────────────────── │    ║    │
│   ║   │  📍 C:\Program Files\nodejs                             │    ║    │
│   ║   │  🏛️ System-wide  •  🖥️ 64-bit  •  📅 2024-01-10       │    ║    │
│   ║   └─────────────────────────────────────────────────────────┘    ║    │
│   ║                                                                   ║    │
│   ╚═══════════════════════════════════════════════════════════════════╝    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

</div>

<br>

### Key Interface Elements

- **Gradient Header** — Beautiful gradient banner with statistics dashboard
- **Smart Search** — Real-time filtering as you type
- **Application Cards** — Clean, expandable cards with all the details
- **Quick Actions** — Copy uninstall commands with one click
- **Export Menu** — Download your data in multiple formats

<br>

---

<br>

## 🔧 Filtering Options

<div align="center">

| Filter | Description | Registry Source |
|:------:|:------------|:----------------|
| **All** | Every installed application | All sources |
| **System** | Machine-wide installations | `HKLM:\SOFTWARE\...\Uninstall` |
| **User** | Current user only | `HKCU:\SOFTWARE\...\Uninstall` |
| **64-bit** | Native x64 applications | Native registry keys |
| **32-bit** | Legacy/WOW64 applications | `WOW6432Node` keys |

</div>

<br>

---

<br>

## 📤 Export Formats

<table>
<tr>
<td align="center" width="33%">

### JSON
```json
{
  "Name": "App",
  "Version": "1.0",
  "Publisher": "Dev",
  ...
}
```
*Complete data with all registry details*

</td>
<td align="center" width="33%">

### CSV
```
Name,Version,Publisher
App,1.0,Dev
...
```
*Spreadsheet-compatible format*

</td>
<td align="center" width="33%">

### Clipboard
```
Quick copy for
pasting anywhere
you need it
```
*Instant sharing*

</td>
</tr>
</table>

<br>

---

<br>

## 📡 API Reference

The embedded web server exposes a clean REST API:

```
GET  /                    →  Web Interface
GET  /api/all             →  List all applications
GET  /api/search?q=term   →  Search applications
GET  /api/icon?path=...   →  Get application icon (base64)
```

<details>
<summary><b>Example API Response</b></summary>

```json
{
  "DisplayName": "Visual Studio Code",
  "DisplayVersion": "1.85.0",
  "Publisher": "Microsoft Corporation",
  "InstallDate": "20240115",
  "InstallLocation": "C:\\Program Files\\Microsoft VS Code",
  "EstimatedSize": 250624,
  "UninstallString": "\"C:\\Program Files\\Microsoft VS Code\\unins000.exe\"",
  "QuietUninstallString": "\"C:\\Program Files\\Microsoft VS Code\\unins000.exe\" /SILENT",
  "Architecture": "x64",
  "Scope": "System",
  "RegistryPath": "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{...}"
}
```

</details>

<br>

---

<br>

## 🏗️ Architecture

```
                              ┌─────────────────────┐
                              │   YOUR BROWSER      │
                              │   localhost:8095    │
                              └──────────┬──────────┘
                                         │
                                         ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                            AppInspector.ps1                                  │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   ┌──────────────────────┐    ┌──────────────────────┐                      │
│   │   HTTP LISTENER      │    │   REGISTRY SCANNER   │                      │
│   │   ──────────────     │    │   ────────────────   │                      │
│   │   Port binding       │◄──►│   HKLM Uninstall     │                      │
│   │   Request routing    │    │   HKLM WOW6432Node   │                      │
│   │   JSON responses     │    │   HKCU Uninstall     │                      │
│   └──────────────────────┘    └──────────────────────┘                      │
│              │                           │                                   │
│              ▼                           ▼                                   │
│   ┌──────────────────────┐    ┌──────────────────────┐                      │
│   │   EMBEDDED FRONTEND  │    │   ICON EXTRACTOR     │                      │
│   │   ──────────────────-│    │   ──────────────     │                      │
│   │   HTML5 / CSS3 / JS  │    │   System.Drawing     │                      │
│   │   Material Dark UI   │    │   Base64 encoding    │                      │
│   │   Responsive Grid    │    │   EXE/DLL icons      │                      │
│   └──────────────────────┘    └──────────────────────┘                      │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

<br>

---

<br>

## 📋 Requirements

| Requirement | Minimum | Recommended |
|:------------|:--------|:------------|
| **Operating System** | Windows 10 | Windows 11 |
| **PowerShell** | 7.0 | 7.4+ |
| **Browser** | Any modern browser | Chrome / Edge |
| **Permissions** | User | Administrator* |

> *Administrator access allows viewing system-wide installations with complete registry access.

<br>

---

<br>

<div align="center">

## 👨‍💻 Author

**John Booth**

*Built with assistance from Claude (Anthropic)*

<br>

---

<br>

### 🙏 Acknowledgments

**Material Design** — Color palette and design principles
**Bootflat** — UI framework inspiration
**Font Awesome** — Beautiful iconography
**Google Fonts** — Roboto font family

<br>

---

<br>

<sub>

Released under the **MIT License** — See [LICENSE](LICENSE) for details.

</sub>

<br>

```
═══════════════════════════════════════════════════════════════════════
                    Made with ♥ and PowerShell
═══════════════════════════════════════════════════════════════════════
```

</div>
