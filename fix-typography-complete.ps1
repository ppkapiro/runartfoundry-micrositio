# Script integral para corregir TODOS los problemas de codificación
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Iniciando corrección integral de caracteres especiales..."

$replacements = @{
    # Caracteres básicos mal codificados
    'Ã³' = 'ó'
    'Ã¡' = 'á'
    'Ã©' = 'é'
    'Ã­' = 'í'
    'Ãº' = 'ú'
    'Ã±' = 'ñ'
    'Ã§' = 'ç'
    'LÃ³pez' = 'López'
    'RÃ­o' = 'Río'
    
    # Símbolos mal codificados
    'â˜°' = '☰'
    'â€¢' = '•'
    'â€™' = '''
    'â€œ' = '"'
    'â€' = '"'
    'â€¦' = '…'
    'â€"' = '–'
    'â€"' = '—'
    'Â·' = '·'
    'Â¿' = '¿'
    'Â¡' = '¡'
    
    # Palabras comunes mal codificadas
    'NavegaciÃ³n' = 'Navegación'
    'navegaciÃ³n' = 'navegación'
    'CronologÃ­a' = 'Cronología'
    'cronologÃ­a' = 'cronología'
    'BiografÃ­a' = 'Biografía'
    'biografÃ­a' = 'biografía'
    'tÃ©cnica' = 'técnica'
    'tÃ©cnicas' = 'técnicas'
    'tÃ©cnico' = 'técnico'
    'fundiciÃ³n' = 'fundición'
    'artÃ­stica' = 'artística'
    'artÃ­sticas' = 'artísticas'
    'prÃ¡ctica' = 'práctica'
    'prÃ¡cticas' = 'prácticas'
    'informaciÃ³n' = 'información'
    'InformaciÃ³n' = 'Información'
    'creaciÃ³n' = 'creación'
    'tradiciÃ³n' = 'tradición'
    'exposiciÃ³n' = 'exposición'
    'migraciÃ³n' = 'migración'
    'MigraciÃ³n' = 'Migración'
    'transformaciÃ³n' = 'transformación'
    'realizaciÃ³n' = 'realización'
    'especializaciÃ³n' = 'especialización'
    'investigaciÃ³n' = 'investigación'
    'tecnologÃ­as' = 'tecnologías'
    'geogrÃ¡fico' = 'geográfico'
    'OrÃ­genes' = 'Orígenes'
    'orÃ­genes' = 'orígenes'
    
    # Verbos en pasado mal codificados
    'naciÃ³' = 'nació'
    'desarrollÃ³' = 'desarrolló'
    'mostrÃ³' = 'mostró'
    'experimentÃ³' = 'experimentó'
    'representÃ³' = 'representó'
    'caracterizÃ³' = 'caracterizó'
    'distinguirÃ­an' = 'distinguirían'
    'incorporÃ³' = 'incorporó'
    'estableciÃ³' = 'estableció'
}

$totalFiles = 0
$correctedFiles = 0

foreach ($file in $htmlFiles) {
    $totalFiles++
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    foreach ($pattern in $replacements.Keys) {
        $replacement = $replacements[$pattern]
        $content = $content -replace [regex]::Escape($pattern), $replacement
    }
    
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        $correctedFiles++
        Write-Host "✓ Corregido: $($file.Name)"
    }
}

Write-Host ""
Write-Host "=== RESUMEN ==="
Write-Host "Archivos procesados: $totalFiles"
Write-Host "Archivos corregidos: $correctedFiles"
Write-Host "¡Corrección integral completada!"