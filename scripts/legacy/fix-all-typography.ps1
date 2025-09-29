# Script para corregir TODOS los caracteres especiales mal codificados
Write-Host "Iniciando corrección masiva de tipografía..."

# Lista de todos los archivos HTML
$htmlFiles = @(
    "*.html",
    "*/*.html", 
    "*/*/*.html"
)

# Mapeo completo de caracteres mal codificados
$replacements = @{
    'Ã³' = 'ó'
    'Ã¡' = 'á' 
    'Ã­' = 'í'
    'Ã©' = 'é'
    'Ã±' = 'ñ'
    'Ã¼' = 'ü'
    'Ã§' = 'ç'
    'â˜°' = '☰'
    'â€¢' = '•'
    'â€' = '"'
    'â€™' = "'"
    'â€œ' = '"'
    'â€' = '"'
    'mÃ¡s' = 'más'
    'CÃ³digo' = 'Código'
    'EstÃ©tico' = 'Estético'
    'TÃ©cnico' = 'Técnico'
    'tÃ©cnico' = 'técnico'
    'PropÃ³sito' = 'Propósito'
    'propÃ³sito' = 'propósito'
    'InformaciÃ³n' = 'Información'
    'informaciÃ³n' = 'información'
    'ExposiciÃ³n' = 'Exposición'
    'exposiciÃ³n' = 'exposición'
    'BiografÃ­a' = 'Biografía'
    'biografÃ­a' = 'biografía'
    'CronologÃ­a' = 'Cronología'
    'cronologÃ­a' = 'cronología'
    'FundiciÃ³n' = 'Fundición'
    'fundiciÃ³n' = 'fundición'
    'ArtÃ­stica' = 'Artística'
    'artÃ­stica' = 'artística'
    'NavegaciÃ³n' = 'Navegación'
    'navegaciÃ³n' = 'navegación'
    'LÃ³pez' = 'López'
    'TÃ©cnicas' = 'Técnicas'
    'tÃ©cnicas' = 'técnicas'
    'ArtÃ­culos' = 'Artículos'
    'artÃ­culos' = 'artículos'
    'aÃ±os' = 'años'
    'menÃº' = 'menú'
    'AcciÃ³n' = 'Acción'
    'acciÃ³n' = 'acción'
    'MetodologÃ­a' = 'Metodología'
    'metodologÃ­a' = 'metodología'
    'PrÃ¡cticas' = 'Prácticas'
    'prÃ¡cticas' = 'prácticas'
    'OrganizaciÃ³n' = 'Organización'
    'organizaciÃ³n' = 'organización'
}

# Obtener todos los archivos HTML
$allFiles = Get-ChildItem -Path $htmlFiles -File -ErrorAction SilentlyContinue

foreach ($file in $allFiles) {
    Write-Host "Procesando: $($file.Name)"
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    foreach ($key in $replacements.Keys) {
        $content = $content -replace [regex]::Escape($key), $replacements[$key]
    }
    
    if ($content -ne $originalContent) {
        Set-Content $file.FullName -Value $content -Encoding UTF8
        Write-Host "  ✓ Corregido: $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "  - Sin cambios: $($file.Name)" -ForegroundColor Yellow
    }
}

Write-Host "¡Corrección completa!" -ForegroundColor Green