$sourceDir  = "E:\torrent"
$targetRoot = "E:\Games"

$dllNames = @(
    "nvngx_dlss.dll",
    "nvngx_dlssd.dll",
    "nvngx_dlssg.dll"
)

$found = 0
$replaced = 0
$errors = 0

Get-ChildItem -Path $targetRoot -Recurse -File -Filter "nvngx_*.dll" -ErrorAction SilentlyContinue | Where-Object {
    $dllNames -contains $_.Name
} | ForEach-Object {

    $found++

    try {
        $source = Join-Path $sourceDir $_.Name
        Copy-Item $source $_.FullName -Force -ErrorAction Stop
        $replaced++
    }
    catch {
        $errors++
        Write-Warning ("Error: " + $_.FullName)
    }

}

Write-Host ""
Write-Host "========== RESULT =========="
Write-Host ("Found files  : " + $found)
Write-Host ("Replaced     : " + $replaced)
Write-Host ("Errors       : " + $errors)
Write-Host "============================"
