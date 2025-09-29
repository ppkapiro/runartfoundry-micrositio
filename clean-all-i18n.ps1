# Script para limpiar atributos data-i18n de todos los archivos HTML
$htmlFiles = Get-ChildItem -Recurse -Path "micrositio" -Filter "*.html"

Write-Host "Limpiando atributos data-i18n de todos los archivos HTML..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Remover todos los atributos data-i18n pero mantener el contenido
    $content = $content -replace '\s*data-i18n="[^"]*"', ''
    $content = $content -replace '\s*data-i18n-placeholder="[^"]*"', ''
    
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        Write-Host "Limpiado: $($file.Name)"
    }
}

Write-Host "Limpieza de atributos data-i18n completada!"