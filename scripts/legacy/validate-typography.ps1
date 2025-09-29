# HERRAMI# Lista COMPLETA de caracteres problemáticos y sus correcciones
$replacements = @{
    # Caracteres básicos mal codificados
    'Ã³' = 'ó'
    'Ã¡' = 'á'
    'Ã­' = 'í'
    'Ã©' = 'é'
    'Ã±' = 'ñ'
    'Ã¼' = 'ü'
    'Ãº' = 'ú'
    'Ã§' = 'ç'
    
    # Signos especiales mal codificados
    'â˜°' = '☰'
    'â€¢' = '•'
    'âš¡' = '⚡'
    'âœ…' = '✅'
    'âœ"' = '✓'
    'â†—' = '↗'
    'Â¿' = '¿'
    'Â¡' = '¡'
    'Â°' = '°'
    'Â©' = '©'
    'â–¶' = '▶'
    'â–¼' = '▼'
    
    # Símbolos matemáticos
    'â‰¥' = '≥'
    'â‰¤' = '≤'
    'â‰ ' = '≠'
    
    # Emojis Unicode mal codificados
    'ðŸ"‚' = '📂'
    'ðŸŒ' = '🌐'
    'ðŸ"¥' = '🔥'
    'ðŸ"–' = '📖'
    'ðŸŽ¬' = '🎬'
    'ðŸ¢' = '🏢'
    'ðŸ¤–' = '🤖'
    'ðŸ"Š' = '📊'
    'ðŸ"ˆ' = '📈'
    'ðŸ"§' = '🔧'
    'ðŸŽ¯' = '🎯'
    'ðŸš€' = '🚀'
    'ðŸ†' = '🏆'
    'ðŸ"' = '🔍'
    'ðŸ"š' = '📚'
    'ðŸ"„' = '🔄'
    'ðŸ' = '🔥'
    
    # Símbolos de estructura/navegación
    'â"œâ"€â"€' = '├──'
    'â"œâ"€' = '├─'
    'â""â"€â"€' = '└──'
    'â""â"€' = '└─'
    'â"œ' = '├'
    'â""' = '└'
    'â"€' = '─'IPOGRÁFICA AUTOMÁTICA
# Script para ejecutar ANTES de cada deploy para garantizar tipografía correcta

Write-Host "🔍 INICIANDO VALIDACIÓN TIPOGRÁFICA COMPLETA..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# Obtener todos los archivos HTML
$allHtmlFiles = Get-ChildItem -Path "*.html", "*/*.html", "*/*/*.html" -File -ErrorAction SilentlyContinue

# Lista completa de caracteres problemáticos y sus correcciones
$replacements = @{
    # Caracteres básicos mal codificados
    'Ã³' = 'ó'
    'Ã¡' = 'á'
    'Ã­' = 'í'
    'Ã©' = 'é'
    'Ã±' = 'ñ'
    'Ã¼' = 'ü'
    'Ãº' = 'ú'
    'Ã§' = 'ç'
    
    # Signos especiales mal codificados
    'â˜°' = '☰'
    'â€¢' = '•'
    'âš¡' = '⚡'
    'âœ…' = '✅'
    'âœ"' = '✓'
    'â†—' = '↗'
    'â–¶' = '▶'
    'Â¿' = '¿'
    'Â¡' = '¡'
    'Â©' = '©'
    
    # Palabras específicas mal codificadas
    'LÃ³pez' = 'López'
    'NavegaciÃ³n' = 'Navegación'
    'CronologÃ­a' = 'Cronología'
    'FundiciÃ³n' = 'Fundición'
    'ArtÃ­stica' = 'Artística'
    'TÃ©cnicas' = 'Técnicas'
    'TÃ©cnico' = 'Técnico'
    'menÃº' = 'menú'
    'mÃ¡s' = 'más'
    'aÃ±os' = 'años'
    'InformaciÃ³n' = 'Información'
    'ExposiciÃ³n' = 'Exposición'
    'BiografÃ­a' = 'Biografía'
    'PropÃ³sito' = 'Propósito'
    'AcciÃ³n' = 'Acción'
    'MetodologÃ­a' = 'Metodología'
    'PrÃ¡cticas' = 'Prácticas'
    'OrganizaciÃ³n' = 'Organización'
    'ArtÃ­culos' = 'Artículos'
    'Ãštiles' = 'Útiles'
    'PÃºblica' = 'Pública'
    'Ãšnicos' = 'Únicos'
}

$totalErrors = 0
$totalFiles = 0
$correctedFiles = @()

foreach ($file in $allHtmlFiles) {
    $totalFiles++
    Write-Host "📄 Analizando: $($file.Name)" -ForegroundColor Yellow
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileErrors = 0
    
    # Aplicar todas las correcciones
    foreach ($key in $replacements.Keys) {
        $matches = ([regex]::Matches($content, [regex]::Escape($key))).Count
        if ($matches -gt 0) {
            $content = $content -replace [regex]::Escape($key), $replacements[$key]
            $fileErrors += $matches
            Write-Host "   ❌ Encontrados $matches casos de: '$key' → '$($replacements[$key])'" -ForegroundColor Red
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
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "📊 RESUMEN DE VALIDACIÓN TIPOGRÁFICA:" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "📁 Archivos analizados: $totalFiles" -ForegroundColor White
Write-Host "🔧 Archivos corregidos: $($correctedFiles.Count)" -ForegroundColor White
Write-Host "❌ Total errores encontrados: $totalErrors" -ForegroundColor White

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
    Write-Host "⚠️  CORRECCIONES APLICADAS. Ejecutar deploy ahora." -ForegroundColor Yellow
}
Write-Host "================================================" -ForegroundColor Cyan