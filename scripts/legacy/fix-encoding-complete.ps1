# Script final para corregir TODOS los caracteres problemáticos
$htmlFiles = Get-ChildItem -Recurse -Path "micrositio" -Filter "*.html"

Write-Host "Aplicando corrección completa de caracteres especiales..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Lista completa de correcciones de caracteres mal codificados
    $content = $content -replace 'Ã³', 'ó'          # ó
    $content = $content -replace 'Ã¡', 'á'          # á  
    $content = $content -replace 'Ã©', 'é'          # é
    $content = $content -replace 'Ã­', 'í'          # í
    $content = $content -replace 'Ãº', 'ú'          # ú
    $content = $content -replace 'Ã±', 'ñ'          # ñ
    $content = $content -replace 'Ã§', 'ç'          # ç
    $content = $content -replace 'LÃ³pez', 'López'
    $content = $content -replace 'RÃ­o', 'Río'
    $content = $content -replace 'naciÃ³', 'nació'
    $content = $content -replace 'desarrollÃ³', 'desarrolló'
    $content = $content -replace 'mostrÃ³', 'mostró'
    $content = $content -replace 'creaciÃ³n', 'creación'
    $content = $content -replace 'tradiciÃ³n', 'tradición'
    $content = $content -replace 'exposiciÃ³n', 'exposición'
    $content = $content -replace 'experimentÃ³', 'experimentó'
    $content = $content -replace 'tÃ©cnicas', 'técnicas'
    $content = $content -replace 'fundiciÃ³n', 'fundición'
    $content = $content -replace 'MigraciÃ³n', 'Migración'
    $content = $content -replace 'migraciÃ³n', 'migración'
    $content = $content -replace 'representÃ³', 'representó'
    $content = $content -replace 'geogrÃ¡fico', 'geográfico'
    $content = $content -replace 'transformaciÃ³n', 'transformación'
    $content = $content -replace 'tecnologÃ­as', 'tecnologías'
    $content = $content -replace 'artÃ­sticas', 'artísticas'
    $content = $content -replace 'artÃ­stica', 'artística'
    $content = $content -replace 'NavegaciÃ³n', 'Navegación'
    $content = $content -replace 'CronologÃ­a', 'Cronología'
    $content = $content -replace 'BiografÃ­a', 'Biografía'
    $content = $content -replace 'biografÃ­a', 'biografía'
    $content = $content -replace 'tÃ©cnica', 'técnica'
    
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        Write-Host "Corregido completamente: $($file.Name)"
    }
}

Write-Host "Corrección completa finalizada!"