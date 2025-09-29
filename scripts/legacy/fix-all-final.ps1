# VALIDADOR TIPOGRÁFICO MASIVO - VERSION SIMPLE Y EFECTIVA
Write-Host "🔥 CORRECCIÓN TIPOGRÁFICA MASIVA INICIADA" -ForegroundColor Red
Write-Host "==========================================" -ForegroundColor Red

$files = Get-ChildItem -Path "*.html", "*/*.html", "*/*/*.html" -File -ErrorAction SilentlyContinue
$totalErrors = 0
$correctedFiles = @()

foreach ($file in $files) {
    Write-Host "📄 Procesando: $($file.Name)" -ForegroundColor Yellow
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileErrors = 0
    
    # Lista de correcciones con conteo
    $corrections = @(
        # Caracteres básicos
        @('Ã³', 'ó'), @('Ã¡', 'á'), @('Ã­', 'í'), @('Ã©', 'é'), @('Ã±', 'ñ'), @('Ã¼', 'ü'), @('Ãº', 'ú'), @('Ã§', 'ç'),
        
        # Símbolos
        @('â˜°', '☰'), @('â€¢', '•'), @('âš¡', '⚡'), @('âœ…', '✅'), @('âœ"', '✓'), @('â†—', '↗'),
        @('Â¿', '¿'), @('Â¡', '¡'), @('Â°', '°'), @('Â©', '©'), @('â–¶', '▶'), @('â–¼', '▼'),
        @('â‰¥', '≥'), @('â‰¤', '≤'), @('â‰ ', '≠'),
        
        # Emojis (usando caracteres directos)
        @('ðŸ"‚', '📂'), @('ðŸŒ', '🌐'), @('ðŸ"¥', '🔥'), @('ðŸ"–', '📖'), @('ðŸŽ¬', '🎬'),
        @('ðŸ¢', '🏢'), @('ðŸ¤–', '🤖'), @('ðŸ"Š', '📊'), @('ðŸ"ˆ', '📈'), @('ðŸ"§', '🔧'),
        @('ðŸŽ¯', '🎯'), @('ðŸš€', '🚀'), @('ðŸ†', '🏆'), @('ðŸ"', '🔍'), @('ðŸ"š', '📚'), @('ðŸ"„', '🔄'),
        
        # Estructura
        @('â"œâ"€â"€', '├──'), @('â"œâ"€', '├─'), @('â""â"€â"€', '└──'), @('â""â"€', '└─'),
        @('â"œ', '├'), @('â""', '└'), @('â"€', '─'),
        
        # Palabras específicas  
        @('LÃ³pez', 'López'), @('NavegaciÃ³n', 'Navegación'), @('CronologÃ­a', 'Cronología'),
        @('FundiciÃ³n', 'Fundición'), @('ArtÃ­stica', 'Artística'), @('TÃ©cnicas', 'Técnicas'),
        @('TÃ©cnico', 'Técnico'), @('menÃº', 'menú'), @('mÃ¡s', 'más'), @('aÃ±os', 'años'),
        @('InformaciÃ³n', 'Información'), @('ExposiciÃ³n', 'Exposición'), @('BiografÃ­a', 'Biografía'),
        @('PropÃ³sito', 'Propósito'), @('AcciÃ³n', 'Acción'), @('MetodologÃ­a', 'Metodología'),
        @('PrÃ¡cticas', 'Prácticas'), @('OrganizaciÃ³n', 'Organización'), @('ArtÃ­culos', 'Artículos'),
        @('Ãštiles', 'Útiles'), @('PÃºblica', 'Pública'), @('Ãšnicos', 'Únicos'), @('Ãreas', 'Áreas')
    )
    
    foreach ($correction in $corrections) {
        $before = $correction[0]
        $after = $correction[1]
        if ($content -match [regex]::Escape($before)) {
            $matches = ([regex]::Matches($content, [regex]::Escape($before))).Count
            $content = $content -replace [regex]::Escape($before), $after
            $fileErrors += $matches
            Write-Host "   ❌ $matches: '$before' → '$after'" -ForegroundColor Red
        }
    }
    
    if ($content -ne $originalContent) {
        Set-Content $file.FullName -Value $content -Encoding UTF8
        $correctedFiles += $file.Name
        $totalErrors += $fileErrors
        Write-Host "   ✅ CORREGIDO: $fileErrors errores" -ForegroundColor Green
    } else {
        Write-Host "   ✨ PERFECTO: Sin errores" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "🎯 RESUMEN FINAL:" -ForegroundColor Magenta
Write-Host "=================" -ForegroundColor Magenta
Write-Host "📁 Archivos: $($files.Count)" -ForegroundColor White
Write-Host "🔧 Corregidos: $($correctedFiles.Count)" -ForegroundColor White  
Write-Host "❌ Errores: $totalErrors" -ForegroundColor White

if ($totalErrors -gt 0) {
    Write-Host ""
    Write-Host "📝 Archivos corregidos:" -ForegroundColor Yellow
    foreach ($file in $correctedFiles) {
        Write-Host "   • $file" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "🚀 ¡LISTOS PARA DEPLOY!" -ForegroundColor Green
}