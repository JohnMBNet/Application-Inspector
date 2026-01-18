# PowerShell Application Inspector
# Deep Registry Analysis with Material Design Dark Mode UI
# Author: John Booth w/ Claude Opus

param(
    [int]$Port = 8095
)

$ErrorActionPreference = "Continue"

$html = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Inspector</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Roboto+Mono:wght@400;500&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --surface-ground: #121212;
            --surface-card: #1e1e1e;
            --surface-overlay: #2d2d2d;
            --surface-hover: #383838;
            --surface-border: #404040;
            --primary: #bb86fc;
            --primary-variant: #3700b3;
            --secondary: #03dac6;
            --secondary-variant: #018786;
            --bf-aqua: #1abc9c;
            --bf-blue: #3498db;
            --bf-purple: #9b59b6;
            --bf-orange: #e67e22;
            --bf-green: #2ecc71;
            --bf-red: #e74c3c;
            --text-high: rgba(255,255,255,0.87);
            --text-medium: rgba(255,255,255,0.60);
            --text-disabled: rgba(255,255,255,0.38);
            --elevation-1: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
            --elevation-2: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
            --elevation-3: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
            --elevation-4: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
        }

        body {
            font-family: 'Roboto', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--surface-ground);
            color: var(--text-high);
            line-height: 1.6;
            min-height: 100vh;
        }

        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: var(--surface-card); }
        ::-webkit-scrollbar-thumb { background: var(--surface-border); border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--text-disabled); }

        .header {
            background: linear-gradient(135deg, var(--primary-variant) 0%, #1a1a2e 50%, var(--secondary-variant) 100%);
            padding: 40px 0 80px;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }

        .container { max-width: 1400px; margin: 0 auto; padding: 0 24px; position: relative; }
        .header-content { display: flex; align-items: center; gap: 20px; }

        .logo {
            width: 64px; height: 64px;
            background: var(--surface-card);
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: var(--elevation-3);
        }
        .logo i { font-size: 32px; color: var(--primary); }

        .header-text h1 { font-size: 36px; font-weight: 300; letter-spacing: -0.5px; margin-bottom: 4px; }
        .header-text .subtitle { color: var(--text-medium); font-size: 16px; font-weight: 400; }

        .search-panel {
            background: var(--surface-card);
            margin: -50px auto 30px;
            max-width: 1000px;
            padding: 32px;
            border-radius: 16px;
            box-shadow: var(--elevation-4);
            border: 1px solid var(--surface-border);
        }

        .search-row { display: flex; gap: 12px; margin-bottom: 20px; }
        .search-input-wrapper { flex: 1; position: relative; }
        .search-input-wrapper i {
            position: absolute; left: 20px; top: 50%; transform: translateY(-50%);
            color: var(--text-disabled); font-size: 20px; transition: color 0.2s;
        }

        .search-input {
            width: 100%;
            padding: 18px 20px 18px 56px;
            background: var(--surface-overlay);
            border: 2px solid transparent;
            border-radius: 12px;
            font-size: 16px;
            color: var(--text-high);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            outline: none;
        }
        .search-input::placeholder { color: var(--text-disabled); }
        .search-input:focus { border-color: var(--primary); background: var(--surface-hover); }

        .btn {
            padding: 18px 32px;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-transform: uppercase;
            letter-spacing: 1px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            white-space: nowrap;
        }
        .btn:active { transform: scale(0.98); }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--bf-purple) 100%);
            color: #000;
            box-shadow: 0 4px 15px rgba(187, 134, 252, 0.3);
        }
        .btn-primary:hover { box-shadow: 0 6px 20px rgba(187, 134, 252, 0.4); transform: translateY(-2px); }

        .btn-secondary {
            background: var(--surface-overlay);
            color: var(--secondary);
            border: 2px solid var(--secondary);
        }
        .btn-secondary:hover { background: rgba(3, 218, 198, 0.1); }

        .btn-icon { padding: 18px; background: var(--surface-overlay); color: var(--text-medium); }
        .btn-icon:hover { background: var(--surface-hover); color: var(--text-high); }

        .filter-row { display: flex; gap: 10px; flex-wrap: wrap; align-items: center; }
        .filter-label { color: var(--text-medium); font-size: 14px; font-weight: 500; margin-right: 8px; }

        .chip {
            padding: 8px 16px;
            background: var(--surface-overlay);
            border: 1px solid var(--surface-border);
            border-radius: 20px;
            font-size: 13px;
            color: var(--text-medium);
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .chip:hover { background: var(--surface-hover); color: var(--text-high); }
        .chip.active { background: rgba(187, 134, 252, 0.15); border-color: var(--primary); color: var(--primary); }
        .chip i { font-size: 12px; }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--surface-card);
            padding: 24px;
            border-radius: 12px;
            border: 1px solid var(--surface-border);
            position: relative;
            overflow: hidden;
        }
        .stat-card::before { content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; }
        .stat-card.purple::before { background: var(--primary); }
        .stat-card.aqua::before { background: var(--secondary); }
        .stat-card.blue::before { background: var(--bf-blue); }
        .stat-card.orange::before { background: var(--bf-orange); }

        .stat-icon {
            width: 48px; height: 48px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 16px;
            font-size: 24px;
        }
        .stat-card.purple .stat-icon { background: rgba(187, 134, 252, 0.15); color: var(--primary); }
        .stat-card.aqua .stat-icon { background: rgba(3, 218, 198, 0.15); color: var(--secondary); }
        .stat-card.blue .stat-icon { background: rgba(52, 152, 219, 0.15); color: var(--bf-blue); }
        .stat-card.orange .stat-icon { background: rgba(230, 126, 34, 0.15); color: var(--bf-orange); }

        .stat-value { font-size: 32px; font-weight: 300; margin-bottom: 4px; }
        .stat-label { font-size: 13px; color: var(--text-medium); text-transform: uppercase; letter-spacing: 0.5px; }

        .loader { display: none; justify-content: center; padding: 60px 0; }
        .loader.active { display: flex; }
        .loader-ring {
            width: 48px; height: 48px;
            border: 3px solid var(--surface-border);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        .results-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .results-count { font-size: 14px; color: var(--text-medium); }
        .results-count strong { color: var(--primary); font-weight: 500; }

        .view-toggle { display: flex; gap: 4px; background: var(--surface-overlay); padding: 4px; border-radius: 8px; }
        .view-btn {
            padding: 8px 12px;
            background: transparent;
            border: none;
            border-radius: 6px;
            color: var(--text-disabled);
            cursor: pointer;
            transition: all 0.2s;
        }
        .view-btn:hover { color: var(--text-medium); }
        .view-btn.active { background: var(--surface-card); color: var(--primary); }

        .results-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
            gap: 20px;
        }

        .app-card {
            background: var(--surface-card);
            border-radius: 16px;
            border: 1px solid var(--surface-border);
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .app-card:hover { border-color: var(--primary); box-shadow: var(--elevation-3); transform: translateY(-4px); }

        .app-card-header {
            background: linear-gradient(135deg, var(--surface-overlay) 0%, var(--surface-hover) 100%);
            padding: 24px;
            display: flex;
            gap: 16px;
            align-items: flex-start;
        }

        .app-icon {
            width: 56px; height: 56px;
            background: var(--surface-card);
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
            border: 2px solid var(--surface-border);
        }
        .app-icon i { font-size: 28px; color: var(--primary); }

        .app-title-section { flex: 1; min-width: 0; }
        .app-name { font-size: 18px; font-weight: 500; margin-bottom: 4px; word-wrap: break-word; }
        .app-version { font-size: 13px; color: var(--secondary); font-family: 'Roboto Mono', monospace; }
        .app-badges { display: flex; gap: 8px; margin-top: 10px; flex-wrap: wrap; }

        .badge {
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .badge-system { background: rgba(52, 152, 219, 0.15); color: var(--bf-blue); }
        .badge-user { background: rgba(46, 204, 113, 0.15); color: var(--bf-green); }
        .badge-x64 { background: rgba(187, 134, 252, 0.15); color: var(--primary); }
        .badge-x86 { background: rgba(230, 126, 34, 0.15); color: var(--bf-orange); }

        .app-card-body { padding: 24px; }
        .info-section { margin-bottom: 20px; }
        .info-section:last-child { margin-bottom: 0; }

        .info-section-title {
            font-size: 12px;
            font-weight: 500;
            color: var(--text-disabled);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .info-section-title i { color: var(--primary); }

        .info-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
        .info-item.full-width { grid-column: span 2; }
        .info-label { font-size: 11px; color: var(--text-disabled); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 4px; }
        .info-value { font-size: 14px; color: var(--text-high); word-break: break-word; }
        .info-value.mono {
            font-family: 'Roboto Mono', monospace;
            font-size: 12px;
            background: var(--surface-overlay);
            padding: 8px 12px;
            border-radius: 6px;
            color: var(--secondary);
        }
        .info-value.path {
            font-family: 'Roboto Mono', monospace;
            font-size: 11px;
            background: var(--surface-ground);
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid var(--surface-border);
            color: var(--text-medium);
            position: relative;
            padding-right: 40px;
        }

        .copy-btn {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            background: var(--surface-overlay);
            border: none;
            padding: 6px 8px;
            border-radius: 4px;
            color: var(--text-disabled);
            cursor: pointer;
            transition: all 0.2s;
        }
        .copy-btn:hover { color: var(--primary); background: var(--surface-hover); }
        .copy-btn.copied { color: var(--bf-green); }

        .registry-section {
            background: var(--surface-ground);
            margin: 0 -24px -24px;
            padding: 20px 24px;
            border-top: 1px solid var(--surface-border);
        }

        .registry-toggle {
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            padding: 4px 0;
        }
        .registry-toggle-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 13px;
            font-weight: 500;
            color: var(--text-medium);
        }
        .registry-toggle-title i.fa-database { color: var(--bf-purple); }
        .registry-toggle i.fa-chevron-down { transition: transform 0.3s; color: var(--text-disabled); }
        .registry-toggle.open i.fa-chevron-down { transform: rotate(180deg); }

        .registry-content { display: none; margin-top: 16px; }
        .registry-content.open { display: block; }

        .registry-entry {
            background: var(--surface-card);
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 8px;
            border: 1px solid var(--surface-border);
        }
        .registry-entry:last-child { margin-bottom: 0; }
        .registry-key-name { font-size: 11px; color: var(--bf-orange); font-family: 'Roboto Mono', monospace; margin-bottom: 4px; }
        .registry-key-value { font-size: 12px; color: var(--text-medium); font-family: 'Roboto Mono', monospace; word-break: break-all; }

        .empty-state { text-align: center; padding: 80px 20px; color: var(--text-disabled); }
        .empty-state i { font-size: 72px; margin-bottom: 24px; opacity: 0.3; }
        .empty-state h2 { font-size: 24px; font-weight: 400; color: var(--text-medium); margin-bottom: 8px; }
        .empty-state p { font-size: 14px; }

        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(4px);
        }
        .modal-overlay.open { display: flex; }

        .modal {
            background: var(--surface-card);
            border-radius: 20px;
            max-width: 500px;
            width: 90%;
            box-shadow: var(--elevation-4);
            border: 1px solid var(--surface-border);
            animation: modalIn 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        @keyframes modalIn {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }

        .modal-header {
            padding: 24px;
            border-bottom: 1px solid var(--surface-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .modal-title { font-size: 20px; font-weight: 500; display: flex; align-items: center; gap: 12px; }
        .modal-title i { color: var(--primary); }

        .modal-close {
            background: none;
            border: none;
            color: var(--text-disabled);
            font-size: 20px;
            cursor: pointer;
            padding: 8px;
            transition: color 0.2s;
        }
        .modal-close:hover { color: var(--text-high); }

        .modal-body { padding: 24px; }
        .export-options { display: flex; flex-direction: column; gap: 12px; }

        .export-option {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 16px;
            background: var(--surface-overlay);
            border: 2px solid var(--surface-border);
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .export-option:hover { border-color: var(--primary); background: var(--surface-hover); }
        .export-option i { font-size: 24px; color: var(--primary); }
        .export-option-text h4 { font-weight: 500; margin-bottom: 2px; }
        .export-option-text p { font-size: 12px; color: var(--text-disabled); }

        .toast {
            position: fixed;
            bottom: 24px;
            left: 50%;
            transform: translateX(-50%) translateY(100px);
            background: var(--surface-card);
            padding: 16px 24px;
            border-radius: 12px;
            box-shadow: var(--elevation-4);
            border: 1px solid var(--surface-border);
            display: flex;
            align-items: center;
            gap: 12px;
            z-index: 2000;
            opacity: 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .toast.show { opacity: 1; transform: translateX(-50%) translateY(0); }
        .toast i { font-size: 20px; }
        .toast.success i { color: var(--bf-green); }
        .toast.error i { color: var(--bf-red); }
        .toast.info i { color: var(--bf-blue); }

        @media (max-width: 768px) {
            .header { padding: 24px 0 60px; }
            .header-text h1 { font-size: 24px; }
            .search-panel { padding: 20px; margin: -40px 16px 24px; }
            .search-row { flex-direction: column; }
            .btn { width: 100%; justify-content: center; }
            .results-grid { grid-template-columns: 1fr; }
            .info-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo"><i class="fas fa-microscope"></i></div>
                <div class="header-text">
                    <h1>Application Inspector</h1>
                    <p class="subtitle">Deep registry analysis for installed applications</p>
                </div>
            </div>
        </div>
    </header>

    <main class="container">
        <section class="search-panel">
            <div class="search-row">
                <div class="search-input-wrapper">
                    <input type="text" class="search-input" id="searchInput" placeholder="Search applications by name, publisher, or version..." autofocus>
                    <i class="fas fa-search"></i>
                </div>
                <button class="btn btn-primary" onclick="searchApps()"><i class="fas fa-search"></i> Inspect</button>
                <button class="btn btn-secondary" onclick="loadAll()"><i class="fas fa-layer-group"></i> All Apps</button>
                <button class="btn btn-icon" onclick="openExportModal()" title="Export Results"><i class="fas fa-download"></i></button>
            </div>
            <div class="filter-row">
                <span class="filter-label">Filter:</span>
                <button class="chip active" data-filter="all" onclick="setFilter('all')"><i class="fas fa-globe"></i> All</button>
                <button class="chip" data-filter="system" onclick="setFilter('system')"><i class="fas fa-desktop"></i> System-wide</button>
                <button class="chip" data-filter="user" onclick="setFilter('user')"><i class="fas fa-user"></i> User Only</button>
                <button class="chip" data-filter="x64" onclick="setFilter('x64')"><i class="fas fa-microchip"></i> 64-bit</button>
                <button class="chip" data-filter="x86" onclick="setFilter('x86')"><i class="fas fa-memory"></i> 32-bit</button>
            </div>
        </section>

        <section class="stats-grid" id="statsGrid" style="display:none;">
            <div class="stat-card purple">
                <div class="stat-icon"><i class="fas fa-cubes"></i></div>
                <div class="stat-value" id="statTotal">0</div>
                <div class="stat-label">Applications Found</div>
            </div>
            <div class="stat-card aqua">
                <div class="stat-icon"><i class="fas fa-building"></i></div>
                <div class="stat-value" id="statPublishers">0</div>
                <div class="stat-label">Unique Publishers</div>
            </div>
            <div class="stat-card blue">
                <div class="stat-icon"><i class="fas fa-desktop"></i></div>
                <div class="stat-value" id="statSystem">0</div>
                <div class="stat-label">System Installs</div>
            </div>
            <div class="stat-card orange">
                <div class="stat-icon"><i class="fas fa-user"></i></div>
                <div class="stat-value" id="statUser">0</div>
                <div class="stat-label">User Installs</div>
            </div>
        </section>

        <div class="loader" id="loader"><div class="loader-ring"></div></div>

        <section id="resultsSection" style="display:none;">
            <div class="results-header">
                <div class="results-count">Showing <strong id="displayCount">0</strong> applications</div>
                <div class="view-toggle">
                    <button class="view-btn active" data-view="grid" onclick="setView('grid')" title="Grid View"><i class="fas fa-th-large"></i></button>
                    <button class="view-btn" data-view="list" onclick="setView('list')" title="List View"><i class="fas fa-list"></i></button>
                </div>
            </div>
            <div class="results-grid" id="resultsGrid"></div>
        </section>

        <div class="empty-state" id="emptyState">
            <i class="fas fa-search"></i>
            <h2>Ready to Inspect</h2>
            <p>Enter an application name or click "All Apps" to browse installed software</p>
        </div>
    </main>

    <div class="modal-overlay" id="exportModal">
        <div class="modal">
            <div class="modal-header">
                <div class="modal-title"><i class="fas fa-download"></i> Export Results</div>
                <button class="modal-close" onclick="closeExportModal()"><i class="fas fa-times"></i></button>
            </div>
            <div class="modal-body">
                <div class="export-options">
                    <div class="export-option" onclick="exportData('json')">
                        <i class="fas fa-file-code"></i>
                        <div class="export-option-text"><h4>JSON Format</h4><p>Complete data with all registry details</p></div>
                    </div>
                    <div class="export-option" onclick="exportData('csv')">
                        <i class="fas fa-file-csv"></i>
                        <div class="export-option-text"><h4>CSV Format</h4><p>Spreadsheet compatible, main fields only</p></div>
                    </div>
                    <div class="export-option" onclick="exportData('clipboard')">
                        <i class="fas fa-clipboard"></i>
                        <div class="export-option-text"><h4>Copy to Clipboard</h4><p>JSON data copied for quick paste</p></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="toast" id="toast"><i class="fas fa-check-circle"></i><span id="toastMessage">Success</span></div>

    <script>
        var currentData = [];
        var filteredData = [];
        var currentFilter = 'all';

        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') searchApps();
        });

        function showLoader() {
            document.getElementById('loader').classList.add('active');
            document.getElementById('emptyState').style.display = 'none';
            document.getElementById('resultsSection').style.display = 'none';
        }

        function hideLoader() {
            document.getElementById('loader').classList.remove('active');
        }

        function showToast(message, type) {
            type = type || 'success';
            var toast = document.getElementById('toast');
            var icon = toast.querySelector('i');
            document.getElementById('toastMessage').textContent = message;
            toast.className = 'toast ' + type;
            icon.className = 'fas fa-' + (type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle');
            toast.classList.add('show');
            setTimeout(function() { toast.classList.remove('show'); }, 3000);
        }

        function searchApps() {
            var query = document.getElementById('searchInput').value.trim();
            if (!query) {
                showToast('Please enter a search term', 'info');
                return;
            }
            showLoader();
            fetch('/api/search?q=' + encodeURIComponent(query))
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    currentData = data.Applications || [];
                    applyFilter();
                    updateStats(data.Stats);
                })
                .catch(function(err) { showToast('Error searching applications', 'error'); })
                .finally(function() { hideLoader(); });
        }

        function loadAll() {
            showLoader();
            showToast('Loading all applications...', 'info');
            fetch('/api/all')
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    currentData = data.Applications || [];
                    applyFilter();
                    updateStats(data.Stats);
                })
                .catch(function(err) { showToast('Error loading applications', 'error'); })
                .finally(function() { hideLoader(); });
        }

        function setFilter(filter) {
            currentFilter = filter;
            document.querySelectorAll('.chip').forEach(function(c) { c.classList.remove('active'); });
            document.querySelector('.chip[data-filter="' + filter + '"]').classList.add('active');
            applyFilter();
        }

        function applyFilter() {
            if (currentFilter === 'all') {
                filteredData = currentData;
            } else if (currentFilter === 'system') {
                filteredData = currentData.filter(function(app) { return app.Scope === 'Machine'; });
            } else if (currentFilter === 'user') {
                filteredData = currentData.filter(function(app) { return app.Scope === 'User'; });
            } else if (currentFilter === 'x64') {
                filteredData = currentData.filter(function(app) { return app.Architecture === 'x64'; });
            } else if (currentFilter === 'x86') {
                filteredData = currentData.filter(function(app) { return app.Architecture === 'x86'; });
            }
            displayResults(filteredData);
        }

        function updateStats(stats) {
            if (!stats) return;
            document.getElementById('statTotal').textContent = stats.TotalApps || 0;
            document.getElementById('statPublishers').textContent = stats.UniquePublishers || 0;
            document.getElementById('statSystem').textContent = stats.SystemInstalls || 0;
            document.getElementById('statUser').textContent = stats.UserInstalls || 0;
            document.getElementById('statsGrid').style.display = 'grid';
        }

        function displayResults(apps) {
            var grid = document.getElementById('resultsGrid');
            var section = document.getElementById('resultsSection');
            var empty = document.getElementById('emptyState');

            if (!apps || apps.length === 0) {
                grid.innerHTML = '';
                section.style.display = 'none';
                empty.innerHTML = '<i class="fas fa-box-open"></i><h2>No Applications Found</h2><p>Try a different search term or filter</p>';
                empty.style.display = 'block';
                return;
            }

            document.getElementById('displayCount').textContent = apps.length;
            empty.style.display = 'none';
            section.style.display = 'block';

            var html = '';
            for (var idx = 0; idx < apps.length; idx++) {
                var app = apps[idx];
                var iconId = 'icon-' + idx;
                html += '<div class="app-card">';
                html += '<div class="app-card-header">';
                if (app.DisplayIcon) {
                    html += '<div class="app-icon" id="' + iconId + '" data-icon="' + escapeHtml(app.DisplayIcon) + '"><i class="fas ' + getAppIcon(app.Name) + '"></i></div>';
                } else {
                    html += '<div class="app-icon"><i class="fas ' + getAppIcon(app.Name) + '"></i></div>';
                }
                html += '<div class="app-title-section">';
                html += '<div class="app-name">' + escapeHtml(app.Name) + '</div>';
                html += '<div class="app-version">' + escapeHtml(app.Version || 'Unknown version') + '</div>';
                html += '<div class="app-badges">';
                html += '<span class="badge ' + (app.Scope === 'Machine' ? 'badge-system' : 'badge-user') + '">' + (app.Scope === 'Machine' ? 'System' : 'User') + '</span>';
                html += '<span class="badge ' + (app.Architecture === 'x64' ? 'badge-x64' : 'badge-x86') + '">' + app.Architecture + '</span>';
                html += '</div></div></div>';

                html += '<div class="app-card-body">';
                html += '<div class="info-section"><div class="info-section-title"><i class="fas fa-info-circle"></i> General Information</div>';
                html += '<div class="info-grid">';
                if (app.Publisher) html += '<div class="info-item"><div class="info-label">Publisher</div><div class="info-value">' + escapeHtml(app.Publisher) + '</div></div>';
                if (app.InstallDate) html += '<div class="info-item"><div class="info-label">Install Date</div><div class="info-value">' + formatDate(app.InstallDate) + '</div></div>';
                if (app.EstimatedSize) html += '<div class="info-item"><div class="info-label">Size</div><div class="info-value">' + formatSize(app.EstimatedSize) + '</div></div>';
                if (app.InstalledBy) html += '<div class="info-item"><div class="info-label">Installed By</div><div class="info-value">' + escapeHtml(app.InstalledBy) + '</div></div>';
                html += '</div></div>';

                if (app.InstallLocation) {
                    html += '<div class="info-section"><div class="info-section-title"><i class="fas fa-folder"></i> Install Location</div>';
                    html += '<div class="info-value path">' + escapeHtml(app.InstallLocation);
                    html += '<button class="copy-btn" data-copy="' + escapeAttr(app.InstallLocation) + '" onclick="copyText(this)"><i class="fas fa-copy"></i></button></div></div>';
                }

                if (app.UninstallString || app.QuietUninstallString) {
                    html += '<div class="info-section"><div class="info-section-title"><i class="fas fa-trash-alt"></i> Uninstall Commands</div>';
                    if (app.UninstallString) {
                        html += '<div class="info-item" style="margin-bottom:10px"><div class="info-label">Standard Uninstall</div>';
                        html += '<div class="info-value path">' + escapeHtml(app.UninstallString);
                        html += '<button class="copy-btn" data-copy="' + escapeAttr(app.UninstallString) + '" onclick="copyText(this)"><i class="fas fa-copy"></i></button></div></div>';
                    }
                    if (app.QuietUninstallString) {
                        html += '<div class="info-item"><div class="info-label">Silent Uninstall</div>';
                        html += '<div class="info-value path">' + escapeHtml(app.QuietUninstallString);
                        html += '<button class="copy-btn" data-copy="' + escapeAttr(app.QuietUninstallString) + '" onclick="copyText(this)"><i class="fas fa-copy"></i></button></div></div>';
                    }
                    html += '</div>';
                }

                if (app.HelpLink || app.URLInfoAbout) {
                    html += '<div class="info-section"><div class="info-section-title"><i class="fas fa-link"></i> Links</div><div class="info-grid">';
                    if (app.HelpLink) html += '<div class="info-item"><div class="info-label">Support</div><div class="info-value"><a href="' + escapeHtml(app.HelpLink) + '" target="_blank" style="color:var(--secondary)">' + truncate(app.HelpLink, 40) + '</a></div></div>';
                    if (app.URLInfoAbout) html += '<div class="info-item"><div class="info-label">About</div><div class="info-value"><a href="' + escapeHtml(app.URLInfoAbout) + '" target="_blank" style="color:var(--secondary)">' + truncate(app.URLInfoAbout, 40) + '</a></div></div>';
                    html += '</div></div>';
                }

                var regKeys = app.RegistryData ? Object.keys(app.RegistryData) : [];
                html += '<div class="registry-section">';
                html += '<div class="registry-toggle" onclick="toggleRegistry(' + idx + ')">';
                html += '<div class="registry-toggle-title"><i class="fas fa-database"></i> Registry Details (' + regKeys.length + ' entries)</div>';
                html += '<i class="fas fa-chevron-down"></i></div>';
                html += '<div class="registry-content" id="registry-' + idx + '">';
                html += '<div class="info-value path" style="margin-bottom:12px">' + escapeHtml(app.RegistryPath);
                html += '<button class="copy-btn" data-copy="' + escapeAttr(app.RegistryPath) + '" onclick="copyText(this)"><i class="fas fa-copy"></i></button></div>';
                if (app.RegistryData) {
                    for (var key in app.RegistryData) {
                        html += '<div class="registry-entry"><div class="registry-key-name">' + escapeHtml(key) + '</div>';
                        html += '<div class="registry-key-value">' + escapeHtml(String(app.RegistryData[key])) + '</div></div>';
                    }
                }
                html += '</div></div>';

                html += '</div></div>';
            }
            grid.innerHTML = html;
            loadIcons();
        }

        function loadIcons() {
            var icons = document.querySelectorAll('.app-icon[data-icon]');
            icons.forEach(function(el) {
                var iconPath = el.getAttribute('data-icon');
                if (iconPath) {
                    var img = new Image();
                    img.onload = function() {
                        el.innerHTML = '';
                        img.style.width = '32px';
                        img.style.height = '32px';
                        img.style.objectFit = 'contain';
                        el.appendChild(img);
                    };
                    img.src = '/api/icon?path=' + encodeURIComponent(iconPath);
                }
            });
        }

        function toggleRegistry(idx) {
            var content = document.getElementById('registry-' + idx);
            var toggle = content.previousElementSibling;
            content.classList.toggle('open');
            toggle.classList.toggle('open');
        }

        function getAppIcon(name) {
            var n = name.toLowerCase();
            if (n.indexOf('chrome') >= 0) return 'fa-chrome';
            if (n.indexOf('firefox') >= 0) return 'fa-firefox';
            if (n.indexOf('edge') >= 0) return 'fa-edge';
            if (n.indexOf('visual studio') >= 0 || n.indexOf('vscode') >= 0) return 'fa-microsoft';
            if (n.indexOf('git') >= 0) return 'fa-git-alt';
            if (n.indexOf('node') >= 0) return 'fa-node-js';
            if (n.indexOf('python') >= 0) return 'fa-python';
            if (n.indexOf('java') >= 0) return 'fa-java';
            if (n.indexOf('adobe') >= 0) return 'fa-adobe';
            if (n.indexOf('steam') >= 0) return 'fa-steam';
            if (n.indexOf('discord') >= 0) return 'fa-discord';
            if (n.indexOf('slack') >= 0) return 'fa-slack';
            if (n.indexOf('spotify') >= 0) return 'fa-spotify';
            if (n.indexOf('dropbox') >= 0) return 'fa-dropbox';
            if (n.indexOf('docker') >= 0) return 'fa-docker';
            if (n.indexOf('aws') >= 0) return 'fa-aws';
            if (n.indexOf('microsoft') >= 0 || n.indexOf('office') >= 0 || n.indexOf('windows') >= 0) return 'fa-microsoft';
            return 'fa-cube';
        }

        function escapeHtml(str) {
            if (!str) return '';
            var div = document.createElement('div');
            div.textContent = str;
            return div.innerHTML;
        }

        function escapeAttr(str) {
            if (!str) return '';
            return str.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        }

        function truncate(str, len) {
            if (!str) return '';
            return str.length > len ? str.substring(0, len) + '...' : str;
        }

        function formatDate(dateStr) {
            if (!dateStr) return 'Unknown';
            if (dateStr.length === 8) {
                return dateStr.substring(0,4) + '-' + dateStr.substring(4,6) + '-' + dateStr.substring(6,8);
            }
            return dateStr;
        }

        function formatSize(kb) {
            if (!kb) return 'Unknown';
            var mb = kb / 1024;
            if (mb >= 1024) return (mb / 1024).toFixed(2) + ' GB';
            if (mb >= 1) return mb.toFixed(2) + ' MB';
            return kb + ' KB';
        }

        function copyText(btn) {
            var text = btn.getAttribute('data-copy');
            if (!text) return;
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(text).then(function() {
                    btn.classList.add('copied');
                    btn.innerHTML = '<i class="fas fa-check"></i>';
                    showToast('Copied to clipboard', 'success');
                    setTimeout(function() {
                        btn.classList.remove('copied');
                        btn.innerHTML = '<i class="fas fa-copy"></i>';
                    }, 2000);
                }).catch(function() {
                    copyTextFallback(btn, text);
                });
            } else {
                copyTextFallback(btn, text);
            }
        }

        function copyTextFallback(btn, text) {
            var textArea = document.createElement('textarea');
            textArea.value = text;
            textArea.style.position = 'fixed';
            textArea.style.left = '-9999px';
            textArea.style.top = '0';
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            try {
                document.execCommand('copy');
                btn.classList.add('copied');
                btn.innerHTML = '<i class="fas fa-check"></i>';
                showToast('Copied to clipboard', 'success');
                setTimeout(function() {
                    btn.classList.remove('copied');
                    btn.innerHTML = '<i class="fas fa-copy"></i>';
                }, 2000);
            } catch (err) {
                showToast('Failed to copy to clipboard', 'error');
            }
            document.body.removeChild(textArea);
        }

        function setView(view) {
            document.querySelectorAll('.view-btn').forEach(function(b) { b.classList.remove('active'); });
            document.querySelector('.view-btn[data-view="' + view + '"]').classList.add('active');
            var grid = document.getElementById('resultsGrid');
            grid.style.gridTemplateColumns = view === 'list' ? '1fr' : 'repeat(auto-fill, minmax(420px, 1fr))';
        }

        function openExportModal() {
            if (filteredData.length === 0) {
                showToast('No data to export. Search for applications first.', 'info');
                return;
            }
            document.getElementById('exportModal').classList.add('open');
        }

        function closeExportModal() {
            document.getElementById('exportModal').classList.remove('open');
        }

        function exportData(format) {
            closeExportModal();
            if (format === 'json') {
                var blob = new Blob([JSON.stringify(filteredData, null, 2)], { type: 'application/json' });
                downloadBlob(blob, 'applications.json');
                showToast('JSON file downloaded', 'success');
            } else if (format === 'csv') {
                var headers = ['Name', 'Version', 'Publisher', 'InstallDate', 'Scope', 'Architecture', 'InstallLocation', 'RegistryPath'];
                var rows = filteredData.map(function(app) {
                    return headers.map(function(h) { return '"' + ((app[h] || '').toString().replace(/"/g, '""')) + '"'; }).join(',');
                });
                var csv = headers.join(',') + '\n' + rows.join('\n');
                var blob = new Blob([csv], { type: 'text/csv' });
                downloadBlob(blob, 'applications.csv');
                showToast('CSV file downloaded', 'success');
            } else if (format === 'clipboard') {
                navigator.clipboard.writeText(JSON.stringify(filteredData, null, 2)).then(function() {
                    showToast('Data copied to clipboard', 'success');
                });
            }
        }

        function downloadBlob(blob, filename) {
            var url = URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = filename;
            a.click();
            URL.revokeObjectURL(url);
        }

        document.getElementById('exportModal').addEventListener('click', function(e) {
            if (e.target === document.getElementById('exportModal')) closeExportModal();
        });
    </script>
</body>
</html>
'@

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()

Write-Host ""
Write-Host "  ╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "  ║                                                               ║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "█████╗ ██████╗ ██████╗     ██╗███╗   ██╗███████╗██████╗ " -ForegroundColor Cyan -NoNewline
Write-Host "   ║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "██╔══██╗██╔══██╗██╔══██╗    ██║████╗  ██║██╔════╝██╔══██╗" -ForegroundColor Cyan -NoNewline
Write-Host "   ║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "███████║██████╔╝██████╔╝    ██║██╔██╗ ██║███████╗██████╔╝" -ForegroundColor Cyan -NoNewline
Write-Host "   ║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "██╔══██║██╔═══╝ ██╔═══╝     ██║██║╚██╗██║╚════██║██╔═══╝ " -ForegroundColor Cyan -NoNewline
Write-Host "   ║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "██║  ██║██║     ██║         ██║██║ ╚████║███████║██║     " -ForegroundColor Cyan -NoNewline
Write-Host "   ║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "╚═╝  ╚═╝╚═╝     ╚═╝         ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     " -ForegroundColor Cyan -NoNewline
Write-Host "   ║" -ForegroundColor Magenta
Write-Host "  ║                                                               ║" -ForegroundColor Magenta
Write-Host "  ╠═══════════════════════════════════════════════════════════════╣" -ForegroundColor Magenta
Write-Host "  ║                                                               ║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "URL:        " -ForegroundColor DarkGray -NoNewline
Write-Host "http://localhost:$Port                            " -ForegroundColor Green -NoNewline
Write-Host "║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "Design:     " -ForegroundColor DarkGray -NoNewline
Write-Host "Material Dark + Bootflat                    " -ForegroundColor Yellow -NoNewline
Write-Host "║" -ForegroundColor Magenta
Write-Host "  ║   " -ForegroundColor Magenta -NoNewline
Write-Host "Author:     " -ForegroundColor DarkGray -NoNewline
Write-Host "John Booth /w Claude Opus                   " -ForegroundColor Cyan -NoNewline
Write-Host "║" -ForegroundColor Magenta
Write-Host "  ║                                                               ║" -ForegroundColor Magenta
Write-Host "  ╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""
Write-Host "  Press Ctrl+C to stop" -ForegroundColor DarkGray
Write-Host ""

# Icon extraction function
Add-Type -AssemblyName System.Drawing

function Get-IconBase64 {
    param([string]$IconPath)

    if (-not $IconPath) { return $null }

    try {
        # Clean up the path - remove icon index if present (e.g., "C:\path\app.exe,0")
        $cleanPath = $IconPath -replace ',[0-9-]+$', ''
        $cleanPath = $cleanPath.Trim('"')

        if (-not (Test-Path $cleanPath)) { return $null }

        $icon = $null
        $bitmap = $null
        $stream = $null

        try {
            if ($cleanPath -match '\.ico$') {
                $icon = [System.Drawing.Icon]::new($cleanPath)
            } else {
                $icon = [System.Drawing.Icon]::ExtractAssociatedIcon($cleanPath)
            }

            if ($icon) {
                $bitmap = $icon.ToBitmap()
                $stream = [System.IO.MemoryStream]::new()
                $bitmap.Save($stream, [System.Drawing.Imaging.ImageFormat]::Png)
                $bytes = $stream.ToArray()
                return [Convert]::ToBase64String($bytes)
            }
        } finally {
            if ($stream) { $stream.Dispose() }
            if ($bitmap) { $bitmap.Dispose() }
            if ($icon) { $icon.Dispose() }
        }
    } catch {
        return $null
    }
    return $null
}

function Get-InstalledApplications {
    param([string]$SearchTerm = "")

    $registryPaths = @(
        @{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"; Scope = "Machine"; Arch = "x64" },
        @{ Path = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"; Scope = "Machine"; Arch = "x86" },
        @{ Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"; Scope = "User"; Arch = "x64" }
    )

    $applications = @()

    foreach ($regInfo in $registryPaths) {
        $regPath = $regInfo.Path
        if (-not (Test-Path $regPath)) { continue }

        try {
            $subKeys = Get-ChildItem -Path $regPath -ErrorAction SilentlyContinue
            foreach ($subKey in $subKeys) {
                try {
                    $props = Get-ItemProperty -Path $subKey.PSPath -ErrorAction SilentlyContinue
                    if (-not $props.DisplayName) { continue }

                    if ($SearchTerm -and $props.DisplayName -notlike "*$SearchTerm*" -and
                        ($null -eq $props.Publisher -or $props.Publisher -notlike "*$SearchTerm*")) {
                        continue
                    }

                    $installedBy = if ($regInfo.Scope -eq "User") {
                        [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
                    } else { "System/Administrator" }

                    $registryData = @{}
                    $props.PSObject.Properties | Where-Object { $_.Name -notlike "PS*" -and $_.Value -ne $null } | ForEach-Object {
                        $registryData[$_.Name] = $_.Value
                    }

                    $applications += @{
                        Name = $props.DisplayName
                        Version = $props.DisplayVersion
                        Publisher = $props.Publisher
                        InstallDate = $props.InstallDate
                        InstallLocation = $props.InstallLocation
                        InstallSource = $props.InstallSource
                        EstimatedSize = $props.EstimatedSize
                        HelpLink = $props.HelpLink
                        URLInfoAbout = $props.URLInfoAbout
                        URLUpdateInfo = $props.URLUpdateInfo
                        UninstallString = $props.UninstallString
                        QuietUninstallString = $props.QuietUninstallString
                        DisplayIcon = $props.DisplayIcon
                        Scope = $regInfo.Scope
                        Architecture = $regInfo.Arch
                        InstalledBy = $installedBy
                        RegistryPath = $subKey.PSPath -replace "Microsoft\.PowerShell\.Core\\Registry::", ""
                        RegistryData = $registryData
                    }
                } catch { }
            }
        } catch {
            Write-Host "  [!] Error reading $regPath" -ForegroundColor Yellow
        }
    }

    $applications = @($applications | Sort-Object { $_.Name })

    return @{
        Applications = @($applications)
        Stats = @{
            TotalApps = $applications.Count
            UniquePublishers = @($applications | Where-Object { $_.Publisher } | Select-Object -ExpandProperty Publisher -Unique).Count
            SystemInstalls = @($applications | Where-Object { $_.Scope -eq "Machine" }).Count
            UserInstalls = @($applications | Where-Object { $_.Scope -eq "User" }).Count
        }
    }
}

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        $response.Headers.Add("Access-Control-Allow-Origin", "*")
        $response.Headers.Add("Content-Type", "application/json; charset=utf-8")

        try {
            $path = $request.Url.AbsolutePath

            if ($path -eq "/") {
                $buffer = [System.Text.Encoding]::UTF8.GetBytes($html)
                $response.ContentType = "text/html; charset=utf-8"
                $response.ContentLength64 = $buffer.Length
                $response.OutputStream.Write($buffer, 0, $buffer.Length)
            }
            elseif ($path -eq "/api/search") {
                $query = $request.QueryString["q"]
                Write-Host "  [*] Searching: $query" -ForegroundColor Cyan
                $result = Get-InstalledApplications -SearchTerm $query
                Write-Host "  [+] Found: $($result.Stats.TotalApps) applications" -ForegroundColor Green
                $json = $result | ConvertTo-Json -Depth 10 -Compress
                $buffer = [System.Text.Encoding]::UTF8.GetBytes($json)
                $response.ContentLength64 = $buffer.Length
                $response.OutputStream.Write($buffer, 0, $buffer.Length)
            }
            elseif ($path -eq "/api/all") {
                Write-Host "  [*] Loading all applications..." -ForegroundColor Yellow
                $result = Get-InstalledApplications
                Write-Host "  [+] Loaded: $($result.Stats.TotalApps) applications" -ForegroundColor Green
                $json = $result | ConvertTo-Json -Depth 10 -Compress
                $buffer = [System.Text.Encoding]::UTF8.GetBytes($json)
                $response.ContentLength64 = $buffer.Length
                $response.OutputStream.Write($buffer, 0, $buffer.Length)
            }
            elseif ($path -eq "/api/icon") {
                $iconPath = $request.QueryString["path"]
                $base64 = Get-IconBase64 -IconPath $iconPath
                if ($base64) {
                    $response.ContentType = "image/png"
                    $bytes = [Convert]::FromBase64String($base64)
                    $response.ContentLength64 = $bytes.Length
                    $response.OutputStream.Write($bytes, 0, $bytes.Length)
                } else {
                    $response.StatusCode = 404
                    $buffer = [System.Text.Encoding]::UTF8.GetBytes("")
                    $response.ContentLength64 = $buffer.Length
                    $response.OutputStream.Write($buffer, 0, $buffer.Length)
                }
            }
            else {
                $response.StatusCode = 404
                $notFoundJson = "{`"error`":`"Not found`"}"
                $buffer = [System.Text.Encoding]::UTF8.GetBytes($notFoundJson)
                $response.ContentLength64 = $buffer.Length
                $response.OutputStream.Write($buffer, 0, $buffer.Length)
            }
        } catch {
            Write-Host "  [!] Error: $($_.Exception.Message)" -ForegroundColor Red
            $response.StatusCode = 500
        }

        $response.Close()
    }
} finally {
    $listener.Stop()
    Write-Host "`n  Server stopped" -ForegroundColor Green
}
