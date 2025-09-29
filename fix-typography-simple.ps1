# Script simplificado para corregir caracteres especiales
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Corrigiendo caracteres especiales en todos los archivos HTML..."

$replacements = @{
    'Ã³' = 'ó'
    'Ã¡' = 'á'
    'Ã©' = 'é'
    'Ã­' = 'í'
    'Ãº' = 'ú'
    'Ã±' = 'ñ'
    'LÃ³pez' = 'López'
    'RÃ­o' = 'Río'
    'NavegaciÃ³n' = 'Navegación'
    'CronologÃ­a' = 'Cronología'
    'BiografÃ­a' = 'Biografía'
    'biografÃ­a' = 'biografía'
    'tÃ©cnica' = 'técnica'
    'tÃ©cnicas' = 'técnicas'
    'fundiciÃ³n' = 'fundición'
    'artÃ­stica' = 'artística'
    'artÃ­sticas' = 'artísticas'
    'informaciÃ³n' = 'información'
    'InformaciÃ³n' = 'Información'
    'creaciÃ³n' = 'creación'
    'tradiciÃ³n' = 'tradición'
    'exposiciÃ³n' = 'exposición'
    'migraciÃ³n' = 'migración'
    'MigraciÃ³n' = 'Migración'
    'transformaciÃ³n' = 'transformación'
    'tecnologÃ­as' = 'tecnologías'
    'geogrÃ¡fico' = 'geográfico'
    'OrÃ­genes' = 'Orígenes'
    'naciÃ³' = 'nació'
    'desarrollÃ³' = 'desarrolló'
    'mostrÃ³' = 'mostró'
    'experimentÃ³' = 'experimentó'
    'representÃ³' = 'representó'
}

$correctedFiles = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    foreach ($pattern in $replacements.Keys) {
        $replacement = $replacements[$pattern]
        $content = $content -replace [regex]::Escape($pattern), $replacement
    }
    
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        $correctedFiles++
        Write-Host "Corregido: $($file.Name)"
    }
}

Write-Host "Archivos corregidos: $correctedFiles"
Write-Host "Corrección completada!"