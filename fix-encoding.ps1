# Script para corregir caracteres especiales en todos los archivos HTML
$htmlFiles = Get-ChildItem -Recurse -Path "micrositio" -Filter "*.html"

Write-Host "Corrigiendo caracteres especiales en archivos HTML..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Corregir caracteres especiales básicos
    $content = $content -replace 'Ã³', 'ó'
    $content = $content -replace 'Ã¡', 'á'
    $content = $content -replace 'Ã©', 'é'
    $content = $content -replace 'Ã­', 'í'
    $content = $content -replace 'Ãº', 'ú'
    $content = $content -replace 'Ã±', 'ñ'
    
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        Write-Host "Corregido: $($file.Name)"
    }
}

Write-Host "Correccion de caracteres especiales completada!"