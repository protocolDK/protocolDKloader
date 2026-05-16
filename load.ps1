Write-Host "[*] Ascension Standalone Test v1" -ForegroundColor Cyan

$loaderDir = "$env:LOCALAPPDATA\Spotify\Users\Cache\Ascension"
New-Item -ItemType Directory -Force -Path $loaderDir | Out-Null

$baseUrl = "https://raw.githubusercontent.com/protocolDK/protocolDKloader/main"

Invoke-WebRequest -Uri "$baseUrl/files/loader.dll" -OutFile "$loaderDir\test.dll"

Write-Host "[+] DLL downloadet - Starter test..." -ForegroundColor Green

# Load DLL direkte fra PowerShell (test)
$testDll = "$loaderDir\test.dll"
rundll32.exe "$testDll",TestEntry

Write-Host "[*] Hvis du ikke ser et vindue, så virker DLL'en ikke endnu" -ForegroundColor Yellow
pause
