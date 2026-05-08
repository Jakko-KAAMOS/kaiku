# render.ps1 — render all exercise .ly files to PDF and MIDI
# Run from eval/scores/ or pass -ScoresDir explicitly

param(
    [string]$ScoresDir = $PSScriptRoot,
    [string]$LilyPond  = "C:\cygwin64\home\minix\github\lilypond-2.26.0-mingw-x86_64\lilypond-2.26.0\bin\lilypond.exe"
)

if (-not (Test-Path $LilyPond)) {
    Write-Error "LilyPond not found at: $LilyPond"
    exit 1
}

$files = Get-ChildItem -Path $ScoresDir -Filter "e*.ly"

if ($files.Count -eq 0) {
    Write-Warning "No exercise files (e*.ly) found in $ScoresDir"
    exit 0
}

Write-Host "Rendering $($files.Count) exercises..." -ForegroundColor Cyan

foreach ($file in $files) {
    Write-Host "  $($file.Name)" -NoNewline
    & $LilyPond --output="$ScoresDir" "$($file.FullName)" 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " FAILED" -ForegroundColor Red
    }
}

Write-Host "Done." -ForegroundColor Cyan
