@echo off
setlocal
cd /d "%~dp0"
set PORT=8080
echo Iniciando DiabRuta Web en http://127.0.0.1:%PORT%/ ...
echo Cierra esta ventana cuando termines de usar la app.
start "" "http://127.0.0.1:%PORT%/"

where python >nul 2>nul
if %errorlevel%==0 (
  python -m http.server %PORT% --bind 127.0.0.1
  goto :eof
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$root = (Get-Location).Path; " ^
  "$listener = New-Object System.Net.HttpListener; " ^
  "$listener.Prefixes.Add('http://127.0.0.1:%PORT%/'); " ^
  "$listener.Start(); " ^
  "$types = @{ '.html'='text/html; charset=utf-8'; '.js'='application/javascript; charset=utf-8'; '.css'='text/css; charset=utf-8'; '.json'='application/json; charset=utf-8'; '.png'='image/png'; '.jpg'='image/jpeg'; '.svg'='image/svg+xml'; '.wasm'='application/wasm'; '.zip'='application/zip'; '.ttf'='font/ttf'; '.otf'='font/otf'; '.ico'='image/x-icon' }; " ^
  "while ($listener.IsListening) { " ^
  "  $ctx = $listener.GetContext(); " ^
  "  $rel = $ctx.Request.Url.AbsolutePath.TrimStart('/'); " ^
  "  if ([string]::IsNullOrEmpty($rel)) { $rel = 'index.html' }; " ^
  "  $file = Join-Path $root ($rel -replace '/', '\'); " ^
  "  if (-not (Test-Path $file -PathType Leaf)) { $file = Join-Path $root 'index.html' }; " ^
  "  $ext = [System.IO.Path]::GetExtension($file).ToLower(); " ^
  "  $ctx.Response.ContentType = if ($types.ContainsKey($ext)) { $types[$ext] } else { 'application/octet-stream' }; " ^
  "  $bytes = [System.IO.File]::ReadAllBytes($file); " ^
  "  $ctx.Response.ContentLength64 = $bytes.Length; " ^
  "  $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length); " ^
  "  $ctx.Response.Close(); " ^
  "}"
