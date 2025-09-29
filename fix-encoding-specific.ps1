# Script para corregir todas las codificaciones problemáticas
$replacements = @{
    'Ã³' = 'ó'
    'Ã¡' = 'á' 
    'Ã©' = 'é'
    'Ã­' = 'í'
    'Ãº' = 'ú'
    'Ã±' = 'ñ'
    'LÃ³pez' = 'López'
    'BiografÃ­a' = 'Biografía'
    'RÃ­o' = 'Río'
    'fundiciÃ³n' = 'fundición'
    'artÃ­stica' = 'artística'
    'tÃ©cnica' = 'técnica'
    'CronologÃ­a' = 'Cronología'
    'NavegaciÃ³n' = 'Navegación'
    'InformaciÃ³n' = 'Información'
    'creatiÃ³n' = 'creación'
    'expresiÃ³n' = 'expresión'
    'tradiciÃ³n' = 'tradición'
    'innovaciÃ³n' = 'innovación'
    'realizaciÃ³n' = 'realización'
    'especializaciÃ³n' = 'especialización'
    'investigaciÃ³n' = 'investigación'
}

$htmlFiles = Get-ChildItem -Recurse -Path "micrositio" -Filter "*.html"

Write-Host "Aplicando correcciones específicas..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    foreach ($pattern in $replacements.Keys) {
        $replacement = $replacements[$pattern]
        $content = $content -replace [regex]::Escape($pattern), $replacement
    }
    
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        Write-Host "Corregido: $($file.Name)"
    }
}

Write-Host "Correcciones completadas!"