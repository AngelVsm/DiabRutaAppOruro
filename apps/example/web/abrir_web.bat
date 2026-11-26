<# :
@echo off
chcp 65001 >nul
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (Get-Content -Raw -Encoding UTF8 '%~f0')"
if errorlevel 1 pause
exit /b
#>

$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path
$listener = $null
$port = 8080

for ($p = 8080; $p -le 8099; $p++) {
    $candidate = New-Object System.Net.HttpListener
    $candidate.Prefixes.Add("http://127.0.0.1:$p/")
    try {
        $candidate.Start()
        $listener = $candidate
        $port = $p
        break
    } catch {
        $candidate.Close()
    }
}

if ($null -eq $listener) {
    Write-Host "No se pudo abrir un puerto local entre 8080 y 8099." -ForegroundColor Red
    exit 1
}

$url = "http://127.0.0.1:$port/"
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DiabRuta Web activo en $url" -ForegroundColor Green
Write-Host "  No cierres esta ventana mientras usas la app." -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

if (-not $env:DIABRUTA_NO_OPEN) {
    Start-Process $url
}

$mimeTypes = @{
    '.html' = 'text/html; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.mjs'  = 'application/javascript; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.json' = 'application/json; charset=utf-8'
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.gif'  = 'image/gif'
    '.svg'  = 'image/svg+xml'
    '.ico'  = 'image/x-icon'
    '.wasm' = 'application/wasm'
    '.zip'  = 'application/zip'
    '.ttf'  = 'font/ttf'
    '.otf'  = 'font/otf'
    '.woff' = 'font/woff'
    '.woff2'= 'font/woff2'
}

try {
    while ($listener.IsListening) {
        $ctx = $listener.GetContext()
        try {
            $rawPath = [System.Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath)
            $rel = $rawPath.TrimStart('/')
            if ([string]::IsNullOrEmpty($rel)) {
                $rel = 'index.html'
            }
            $file = Join-Path $root ($rel -replace '/', '\')
            if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
                $file = Join-Path $root 'index.html'
            }

            $ext = [System.IO.Path]::GetExtension($file).ToLowerInvariant()
            if ($mimeTypes.ContainsKey($ext)) {
                $ctx.Response.ContentType = $mimeTypes[$ext]
            } else {
                $ctx.Response.ContentType = 'application/octet-stream'
            }

            $bytes = [System.IO.File]::ReadAllBytes($file)
            $ctx.Response.StatusCode = 200
            $ctx.Response.ContentLength64 = $bytes.Length
            $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        } catch {
            try { $ctx.Response.StatusCode = 500 } catch {}
        } finally {
            try { $ctx.Response.OutputStream.Close() } catch {}
            try { $ctx.Response.Close() } catch {}
        }
    }
} finally {
    $listener.Stop()
    $listener.Close()
}
