# Script para limpiar atributos data-i18n del index.html
$filePath = "c:\Users\pepec\Projects\RunArtFoundry\micrositio\index.html"
$content = Get-Content $filePath -Raw -Encoding UTF8

Write-Host "Limpiando atributos data-i18n del index.html..."

# Remover todos los atributos data-i18n pero mantener el contenido
$content = $content -replace '\s*data-i18n="[^"]*"', ''
$content = $content -replace '\s*data-i18n-placeholder="[^"]*"', ''

$content | Out-File -FilePath $filePath -Encoding UTF8

Write-Host "Limpieza completada!"