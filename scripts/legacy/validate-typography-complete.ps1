# VALIDADOR TIPOGRÁFICO COMPLETO V2.0
# Script mejorado para detectar y corregir TODOS los caracteres problemáticos

Write-Host "🔧 VALIDADOR TIPOGRÁFICO COMPLETO V2.0" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta

# Obtener todos los archivos HTML
$allHtmlFiles = Get-ChildItem -Path "*.html", "*/*.html", "*/*/*.html" -File -ErrorAction SilentlyContinue

$totalErrors = 0
$totalFiles = 0
$correctedFiles = @()

foreach ($file in $allHtmlFiles) {
    $totalFiles++
    Write-Host "📄 Analizando: $($file.Name)" -ForegroundColor Yellow
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileErrors = 0
    
    # BLOQUE 1: Caracteres básicos acentuados
    $basicReplacements = @(
        @('Ã³', 'ó'),
        @('Ã¡', 'á'), 
        @('Ã­', 'í'),
        @('Ã©', 'é'),
        @('Ã±', 'ñ'),
        @('Ã¼', 'ü'),
        @('Ãº', 'ú'),
        @('Ã§', 'ç')
    )
    
    foreach ($replacement in $basicReplacements) {
        $before = $replacement[0]
        $after = $replacement[1]
        $matches = ([regex]::Matches($content, [regex]::Escape($before))).Count
        if ($matches -gt 0) {
            $content = $content -replace [regex]::Escape($before), $after
            $fileErrors += $matches
            Write-Host "   ❌ $matches casos: '$before' → '$after'" -ForegroundColor Red
        }
    }
    
    # BLOQUE 2: Símbolos especiales
    $symbolReplacements = @(
        @('â˜°', '☰'),
        @('â€¢', '•'),
        @('âš¡', '⚡'),
        @('âœ…', '✅'),
        @('âœ"', '✓'),
        @('â†—', '↗'),
        @('Â¿', '¿'),
        @('Â¡', '¡'),
        @('Â°', '°'),
        @('Â©', '©'),
        @('â–¶', '▶'),
        @('â–¼', '▼'),
        @('â‰¥', '≥'),
        @('â‰¤', '≤'),
        @('â‰ ', '≠')
    )
    
    foreach ($replacement in $symbolReplacements) {
        $before = $replacement[0]
        $after = $replacement[1]
        $matches = ([regex]::Matches($content, [regex]::Escape($before))).Count
        if ($matches -gt 0) {
            $content = $content -replace [regex]::Escape($before), $after
            $fileErrors += $matches
            Write-Host "   ❌ $matches casos: '$before' → '$after'" -ForegroundColor Red
        }
    }
    
    # BLOQUE 3: Emojis Unicode (método directo)
    $emojiReplacements = @(
        @('ðŸ"‚', '📂'),
        @('ðŸŒ', '🌐'),
        @('ðŸ"¥', '🔥'),
        @('ðŸ"–', '📖'),
        @('ðŸŽ¬', '🎬'),
        @('ðŸ¢', '🏢'),
        @('ðŸ¤–', '🤖'),
        @('ðŸ"Š', '📊'),
        @('ðŸ"ˆ', '📈'),
        @('ðŸ"§', '🔧'),
        @('ðŸŽ¯', '🎯'),
        @('ðŸš€', '🚀'),
        @('ðŸ†', '🏆'),
        @('ðŸ"', '🔍'),
        @('ðŸ"š', '📚'),
        @('ðŸ"„', '🔄'),
        @('ðŸ', '🔥')
    )
    
    foreach ($replacement in $emojiReplacements) {
        $before = $replacement[0]
        $after = $replacement[1]
        $matches = ([regex]::Matches($content, [regex]::Escape($before))).Count
        if ($matches -gt 0) {
            $content = $content -replace [regex]::Escape($before), $after
            $fileErrors += $matches
            Write-Host "   ❌ $matches casos: '$before' → '$after'" -ForegroundColor Red
        }
    }
    
    # BLOQUE 4: Símbolos de estructura
    $structureReplacements = @(
        @('â"œâ"€â"€', '├──'),
        @('â"œâ"€', '├─'),
        @('â""â"€â"€', '└──'),
        @('â""â"€', '└─'),
        @('â"œ', '├'),
        @('â""', '└'),
        @('â"€', '─')
    )
    
    foreach ($replacement in $structureReplacements) {
        $before = $replacement[0]
        $after = $replacement[1]
        $matches = ([regex]::Matches($content, [regex]::Escape($before))).Count
        if ($matches -gt 0) {
            $content = $content -replace [regex]::Escape($before), $after
            $fileErrors += $matches
            Write-Host "   ❌ $matches casos: '$before' → '$after'" -ForegroundColor Red
        }
    }
    
    # BLOQUE 5: Palabras específicas mal codificadas
    $wordReplacements = @(
        @('LÃ³pez', 'López'),
        @('NavegaciÃ³n', 'Navegación'),
        @('CronologÃ­a', 'Cronología'),
        @('FundiciÃ³n', 'Fundición'),
        @('ArtÃ­stica', 'Artística'),
        @('TÃ©cnicas', 'Técnicas'),
        @('TÃ©cnico', 'Técnico'),
        @('menÃº', 'menú'),
        @('mÃ¡s', 'más'),
        @('aÃ±os', 'años'),
        @('InformaciÃ³n', 'Información'),
        @('ExposiciÃ³n', 'Exposición'),
        @('BiografÃ­a', 'Biografía'),
        @('PropÃ³sito', 'Propósito'),
        @('AcciÃ³n', 'Acción'),
        @('MetodologÃ­a', 'Metodología'),
        @('PrÃ¡cticas', 'Prácticas'),
        @('OrganizaciÃ³n', 'Organización'),
        @('ArtÃ­culos', 'Artículos'),
        @('Ãštiles', 'Útiles'),
        @('PÃºblica', 'Pública'),
        @('Ãšnicos', 'Únicos'),
        @('Ãreas', 'Áreas')
    )
    
    foreach ($replacement in $wordReplacements) {
        $before = $replacement[0]
        $after = $replacement[1]
        $matches = ([regex]::Matches($content, [regex]::Escape($before))).Count
        if ($matches -gt 0) {
            $content = $content -replace [regex]::Escape($before), $after
            $fileErrors += $matches
            Write-Host "   ❌ $matches casos: '$before' → '$after'" -ForegroundColor Red
        }
    }
    
    # Guardar si hay cambios
    if ($content -ne $originalContent) {
        Set-Content $file.FullName -Value $content -Encoding UTF8
        $correctedFiles += $file.Name
        $totalErrors += $fileErrors
        Write-Host "   ✅ CORREGIDO: $fileErrors errores tipográficos" -ForegroundColor Green
    } else {
        Write-Host "   ✨ PERFECTO: Sin errores tipográficos" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Magenta
Write-Host "📊 RESUMEN FINAL:" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta
Write-Host "📁 Archivos analizados: $totalFiles" -ForegroundColor White
Write-Host "🔧 Archivos corregidos: $($correctedFiles.Count)" -ForegroundColor White
Write-Host "❌ Total errores corregidos: $totalErrors" -ForegroundColor White

if ($correctedFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "📝 Archivos corregidos:" -ForegroundColor Yellow
    foreach ($file in $correctedFiles) {
        Write-Host "   • $file" -ForegroundColor White
    }
}

Write-Host ""
if ($totalErrors -eq 0) {
    Write-Host "🎉 ¡SITIO LISTO PARA DEPLOY! Tipografía perfecta." -ForegroundColor Green
} else {
    Write-Host "⚠️  $totalErrors ERRORES CORREGIDOS. Ejecutar deploy ahora." -ForegroundColor Yellow
}
Write-Host "=========================================" -ForegroundColor Magenta